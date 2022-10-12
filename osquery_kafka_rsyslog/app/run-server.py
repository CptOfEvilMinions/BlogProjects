# flake8: noqa
# pylint: skip-file
import json
from datetime import datetime

import requests
import yaml
from kafka import KafkaConsumer


def slack_alert(cfg, file_sha256_hash, hostname, file_path, report):
    slack_url = cfg["slack"]["webhook_url"]

    # Create message with attributes
    msg = "[+] Malicious file: {0} - {1} - {2} - `{3}` ".format(
        file_path, hostname, file_sha256_hash, report.json()["permalink"]
    )

    # Generate payload
    payload = json.dumps({"text": str(msg)}).encode("utf-8")

    # Generate headers
    headers = {"Content-Type": "application/json"}

    # Make post request
    response = None  # noqa: F841
    try:
        response = requests.post(url=slack_url, data=payload, headers=headers)
    except Exception as e:
        print("[-] Slack error: {0} - {1}\n".format(datetime.now(), e))

    print("{0} - Slack sent message: {1}\n".format(datetime.now(), msg))


def query_virustotal(file_sha256_hash, cfg):
    vt_base_url = cfg["virustotal"]["base_url"]
    vt_api_key = cfg["virustotal"]["api_key"]
    vt_threshold = cfg["virustotal"]["threshold"]

    # Create HTTP request
    url = vt_base_url + "file/report"
    params = {"apikey": vt_api_key, "resource": file_sha256_hash}

    # POST request
    res = requests.post(url, data=params)

    # Get JSON response
    vt_resp = res.json()

    # Hit rate positive hits / total scanners
    hit_rate = int(vt_resp["positives"]) / int(vt_resp["total"])

    # If hit_rate surpasses threshold, return true
    if hit_rate >= vt_threshold:
        return True, res

    return False, res


def get_file_attributes(message):
    file_sha256_hash = message["columns"]["sha256"]
    hostname = message["hostIdentifier"]
    file_path = message["columns"]["target_path"]
    return file_sha256_hash, hostname, file_path


def get_config():
    ymlfile = open("config/config.yml", "r")
    cfg = yaml.safe_load(ymlfile)
    ymlfile.close()

    return cfg


def create_kafka_consumer(cfg):
    kafka_topic = cfg["kafka"]["topic"]
    kafka_hostname = cfg["kafka"]["hostname"]
    kafka_port = cfg["kafka"]["port"]
    return KafkaConsumer(
        kafka_topic,
        bootstrap_servers=["{0}:{1}".format(kafka_hostname, kafka_port)],
        value_deserializer=lambda x: json.loads(x.decode("utf-8")),
    )


def main():
    # Read config values
    cfg = get_config()

    # Create Kafka consumer
    consumer = create_kafka_consumer(cfg)

    for message in consumer:
        message = message.value

        # Get SHA256 hash from message
        file_sha256_hash, hostname, file_path = get_file_attributes(message)
        print(
            "[*] - {0} Scanning file: {1} - {2} - {3}".format(
                datetime.now(), file_path, hostname, file_sha256_hash
            )
        )

        # Query Virustotal
        query_bool, report = query_virustotal(file_sha256_hash, cfg)
        if query_bool:
            print(
                "[+] - {0} Malicious file: {1} - {2} - {3}".format(
                    datetime.now(), file_path, hostname, file_sha256_hash
                )
            )
            slack_alert(cfg, file_sha256_hash, hostname, file_path, report)


main()
