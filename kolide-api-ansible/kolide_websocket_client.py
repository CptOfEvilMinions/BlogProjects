# flake8: noqa
# pylint: skip-file
##########################################################################################
# Author: Ben Bornholm
# Date: 10-17-2020
# The purpose of this script is to demonstrate how to use the Kolide API and WebSockets
# portion of the API with Python.
##########################################################################################
import argparse
import getpass
import json
import ssl
from os import environ, path
from pathlib import Path

import requests
import urllib3
import yaml
from websocket import create_connection

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


def generateJSONAuthHeader(kolide_token):
    """
    Input: Takes in Kolide JWT token
    Output: Returns JSON payload for authenticating websocket to Kolide
    """
    websocket_auth_payload = {"type": "auth", "data": {"token": kolide_token}}
    return json.dumps(websocket_auth_payload)


def generateKoldieQueryCampaignIDJSONpayload(koldie_query_campaign_id):
    """
    Input: Takes in Kolide query campaign ID
    Output: Returns JSON payload for querying result(s) of query
    """
    koldie_query_campaign_id_payload = {
        "type": "select_campaign",
        "data": {"campaign_id": koldie_query_campaign_id},
    }
    return json.dumps(koldie_query_campaign_id_payload)


def getKolideLiveQueryResults(
    base_url, kolide_token, koldie_query_campaign_id
) -> list():
    """
    Input: Kolide base URL, Kolide JWT, query ID
    Output: Return results from websocket for query ID
    """
    # Generate Kolide URL
    kolide_websocket_uri = f"wss://{':'.join( base_url.split(':')[1:])[2:]}/api/v1/kolide/results/websocket"

    # Disable SSL cert verification
    # Init client websocket connection
    ws = create_connection(kolide_websocket_uri, sslopt={"cert_reqs": ssl.CERT_NONE})

    # Send Kolide JWT token
    print("Sending JWT")
    ws.send(generateJSONAuthHeader(kolide_token))

    # Send campaign ID to websocket
    print("Sending campaign ID")
    ws.send(generateKoldieQueryCampaignIDJSONpayload(koldie_query_campaign_id))

    # Keep websocket until all data has been received
    print("Receiving...")
    result_list = list()
    counter = 0
    max_results = 0
    while True:
        recv_text = ws.recv()
        result = recv_text
        result = json.loads(result)

        # get results count
        if result.get("type") == "totals":
            max_results = result.get("data").get("count")

        # Add results to list
        if result.get("type") == "result":
            counter = counter + 1
            osq_hostname = result.get("data").get("host").get("hostname")
            osq_uuid = result.get("data").get("host").get("uuid")
            print(f"Host { osq_hostname }:{ osq_uuid } has submitted results")
            print(f"Received the following number of results: {counter}/{max_results}")
            result_list.append(result)

        # Break while
        if (
            result.get("type") == "status"
            and result.get("data").get("status") == "finished"
        ):
            break

    ws.close()
    print("Close socket")

    print(result_list)
    print(len(result_list))
    return result_list


def createKolideLiveQuery(
    base_url, kolide_token, osquery_query, kolide_hosts=[], kolide_labels=[]
) -> int:
    """
    Input: Takes in Kolide base URL, Kolide JWT for auth, a query to run on endpoints,
    optional list of hosts, optional list of labels.
    Note: kolide_hosts or kolide_labels must be specified
    Output: Returns Kolide query campaign ID
    """
    auth_header = {"Authorization": f"Bearer {kolide_token}"}

    json_payload = {
        "query": f"{osquery_query}",
        "selected": {"Labels": kolide_labels, "Hosts": kolide_hosts},
    }

    url = f"{base_url}/api/v1/kolide/queries/run_by_names"
    r = requests.post(
        url=url, data=json.dumps(json_payload), headers=auth_header, verify=False
    )
    return r.json()["campaign"]["id"]


def authenticateToKolide() -> str:
    """
    Input: None
    Output: Return Kolide JWT token
    """
    # Read Kolide JWT token from ENV variable
    if (
        environ.get("KOLIDE_TOKEN") is not None
        and environ.get("KOLIDE_BASE_URL") is not None
    ):
        return environ.get("KOLIDE_TOKEN")

    # Read Kolide JWT token from Fleet config
    elif path.exists(f"{str(Path.home())}/.fleet/config"):
        kolide_token = str()
        kolide_url = str()
        with open(f"{str(Path.home())}/.fleet/config", "r") as yamlf:
            documents = yaml.full_load(yamlf)
            kolide_token = documents["contexts"]["default"]["token"]
            kolide_url = documents["contexts"]["default"]["address"]
        return kolide_token, kolide_url

    # Authenticate to Kokide with username and password
    else:
        # Get credentials from user
        kolide_username = input("Enter username for Kolide: ")
        kolide_password = getpass.getpass(prompt="Enter password for Kolide: ")
        kolide_base_url = input("Enter Kolide URL: ")

        payload = {"Username": kolide_username, "Password": kolide_password}
        url = f"{kolide_base_url}/api/v1/kolide/login"

        r = requests.post(url=url, data=json.dumps(payload), verify=False)
        return r.json()["token"], kolide_base_url


if __name__ == "__main__":
    # Command line arguments
    parser = argparse.ArgumentParser(description="Process some integers.")
    parser.add_argument(
        "--campaign_id", type=int, help="an integer for the accumulator"
    )
    args = parser.parse_args()

    # Get Kolide JWT token
    kolide_token, base_url = authenticateToKolide()

    if args.campaign_id is None:
        # Ask user for query and hosts
        user_query = input("Enter a query: ") or "SELECT * FROM osquery_info"
        hosts = input("Enter a comma seperated list of hosts to run query on: ") or ""
        labels = input("Enter a comma seperated list of labels to run query on: ") or ""

        if hosts != "" and labels != "":
            labels = [x.strip() for x in labels.split(",")]
            hosts = [x.strip() for x in hosts.split(",")]
        elif labels != "":
            labels = [x.strip() for x in labels.split(",")]
        elif hosts != "":
            hosts = [x.strip() for x in hosts.split(",")]
        else:
            print("Please specify Kolide hosts or labels")
            exit()

        print(user_query)
        print(hosts)
        print(labels)

        koldie_query_campaign_id = createKolideLiveQuery(
            base_url, kolide_token, user_query, hosts
        )
        print(f"Kolide query campaign ID: {koldie_query_campaign_id}")

        # Get results
        getKolideLiveQueryResults(base_url, kolide_token, koldie_query_campaign_id)

    else:
        getKolideLiveQueryResults(base_url, kolide_token, args.campaign_id)
