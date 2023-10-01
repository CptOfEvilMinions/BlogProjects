# pylint: skip-file
import argparse
import csv
import json  # noqa: F401

import communityid


def generate_community_id(
    src_ip, src_port, dest_ip, dest_port, protocol
) -> str():  # noqa: E501
    """
    Input: source IP address, source port, destination IP address, destination port, protocol # noqa: E501
    Output: CommunityID in string format
    """
    cid = communityid.CommunityID()

    tpl = None
    if protocol == "tcp":
        tpl = communityid.FlowTuple.make_tcp(
            src_ip, dest_ip, src_port, dest_port
        )  # noqa: E501
    if protocol == "udp":
        tpl = communityid.FlowTuple.make_udp(
            src_ip, dest_ip, src_port, dest_port
        )  # noqa: E501

    return cid.calc(tpl)


if __name__ == "__main__":
    my_parser = argparse.ArgumentParser()
    my_parser.add_argument("--file", action="store", type=str, required=True)
    args = my_parser.parse_args()

    with open(args.file, "r") as csv_file:
        csv_reader = csv.DictReader(csv_file, delimiter=",")

        for row in csv_reader:
            sysmon_cid = row["network.community_id"]
            src_ip = row["source.ip"]
            src_port = row["source.port"]
            dest_ip = row["destination.ip"]
            dest_port = row["destination.port"]
            protocol = row["network.transport"]

            gen_cid = generate_community_id(
                src_ip, src_port, dest_ip, dest_port, protocol
            )

            if gen_cid != sysmon_cid:
                print(
                    f"[-] - Source IP: {src_ip} Source port: {src_port} Destination IP: {dest_ip} Destination port: {dest_port} Protocol: {protocol} Sysmon CID: {sysmon_cid} Community ID: {gen_cid}"  # noqa: E501
                )
            else:
                print(
                    f"[+] - Source IP: {src_ip} Source port: {src_port} Destination IP: {dest_ip} Destination port: {dest_port} Protocol: {protocol} Sysmon CID: {sysmon_cid} Community ID: {gen_cid}"  # noqa: E501
                )
