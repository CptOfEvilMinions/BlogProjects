# flake8: noqa
# pylint: skip-file
import json
from configparser import ConfigParser
from datetime import datetime

import requests
from confluent_kafka import Consumer, KafkaError, Producer
from confluent_kafka.admin import (
    AdminClient,
    ConfigResource,
    ConfigSource,
    NewPartitions,
    NewTopic,
)


def delivery_report(err, msg):
    """
    Input: Take in error from kafka and msg being pushed to topic
    Output: Return nothing just print error
    """
    """Called once for each message produced to indicate delivery result.
    Triggered by poll() or flush()."""
    if err is not None:
        print("[-] {0} - Message delivery failed: {1}".format(datetime.now(), err))
    else:
        print(
            "[-] {0} - Message delivered to {1} [{2}]".format(
                datetime.now(), msg.topic(), msg.partition()
            )
        )


def vti_enrich_url(vti_api_key, data):
    """
    Input: Take in a msg
    Task: Query VTI with URL to get a rating and append URL ranking
    Output: Return msg enriched  with URL ranking
    """
    vti_url = (
        "https://www.virustotal.com/vtapi/v2/url/report?apikey={0}&resource={1}".format(
            vti_api_key, data["columns"]["url"]
        )
    )
    r = requests.get(vti_url)

    if r.text == "":
        data["url_ranking"] = "None"
    elif r.json()["verbose_msg"] == "Resource does not exist in the dataset":
        data["url_ranking"] = "None"
    else:
        url_ranking = str(r.json()["positives"]) + "/" + str(r.json()["total"])
        print(url_ranking)
        data["url_ranking"] = url_ranking

    return data


def push_enriched_msg_to_kafka(enriched_data, kafka_producer):
    """
    Input: Take in enriched msg and kafka_producer connector
    Task: Push enriched msg to kafka
    Output: Return nothing
    """
    # Trigger any available delivery report callbacks from previous produce() calls
    kafka_producer.poll(0)

    # Push enriched message to Kafka topic
    # replace all single quotes with double quotes like traditional JSON
    kafka_producer.produce(
        "{0}".format(kafka_osquery_enriched_topic),
        bytes(str(enriched_data).replace("'", '"'), "utf-8"),
        callback=delivery_report,
    )

    # Wait for any outstanding messages to be delivered and delivery report
    # callbacks to be triggered.
    kafka_producer.flush()


def read_kafka_topic(kafka_consumer, kafka_producer, vti_api_key):
    """
    Input: Take in kafka consumer connector and kafka producer connector
    Task: Pull all messages from Kafka topic
    Output: Return nothing
    """
    # Read messages from topic
    print("[+] {0} - Reading messages from topic".format(datetime.now()))

    while True:
        msg = kafka_consumer.poll(1.0)

        if msg is None:
            continue
        if msg.error():
            print("[-] {0} - Consumer error: {1}".format(datetime.now(), msg.error()))
            continue

        # Encode msg
        msg_dict = json.loads(msg.value().decode("utf-8"))

        # Extract URL and enriched it
        enriched_data = vti_enrich_url(vti_api_key, msg_dict)

        print("Enriched data: {0}".format(enriched_data))

        # Push enriched data to topic
        push_enriched_msg_to_kafka(enriched_data, kafka_producer)


if __name__ == "__main__":
    # Get config
    config = ConfigParser()
    config.read("config/config.ini")

    kafka_server = config["docker"]["kafka_server"]
    kafka_port = config["docker"]["kafka_port"]
    kafka_osquery_raw_topic = config["docker"]["kafka_osquery_raw_topic"]
    kafka_osquery_enriched_topic = config["docker"]["kafka_osquery_enriched_topic"]

    vti_api_key = config["docker"]["vti_api_key"]

    # Print settings
    print("[+] {0} - kafka_server: {1}".format(datetime.now(), kafka_server))
    print("[+] {0} - kafka_port: {1}".format(datetime.now(), kafka_port))
    print(
        "[+] {0} - kafka_osquery_raw_topic: {1}".format(
            datetime.now(), kafka_osquery_raw_topic
        )
    )
    print(
        "[+] {0} - kafka_osquery_enriched_topic: {1}".format(
            datetime.now(), kafka_osquery_enriched_topic
        )
    )

    # Consumer connector
    kafka_consumer = Consumer(
        {
            "bootstrap.servers": "{0}:{1}".format(kafka_server, kafka_port),
            "group.id": "mygroup",
            "auto.offset.reset": "earliest",
        }
    )

    # Producer connector
    kafka_producer = Producer(
        {"bootstrap.servers": "{0}:{1}".format(kafka_server, kafka_port)}
    )
    print("[+] {0} - Created Kafka producer connector".format(datetime.now()))

    # Subscribe to osquery raw topic
    kafka_consumer.subscribe([kafka_osquery_raw_topic])
    print("[+] {0} - Created Kafka consumer connector".format(datetime.now()))

    try:
        read_kafka_topic(kafka_consumer, kafka_producer, vti_api_key)
    except Exception as e:
        print(e)
        print("Something went wrong when writing to the file")

    # Wait for any outstanding messages to be delivered and delivery report
    # callbacks to be triggered.
    kafka_producer.flush()

    # Close connection to Kafka server
    print("[*] {0} Closing kafka consumer connection".format(datetime.now()))
    kafka_consumer.close()
