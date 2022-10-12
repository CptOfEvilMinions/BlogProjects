# flake8: noqa
# pylint: skip-file
#!/usr/bin/env python
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))
from datetime import datetime  # noqa: E402, F401

import communityid  # noqa: E402
from splunklib.searchcommands import Option  # noqa: E402
from splunklib.searchcommands import (
    Configuration,
    StreamingCommand,
    dispatch,
    validators,
)


def generate_community_id(src_ip, src_port, dest_ip, dest_port, protocol):
    # Init CommunityID  object
    cid = communityid.CommunityID()
    community_id = str()

    # Calculate community ID
    # Protocol
    # TCP: 6
    # UDP: 17
    # https://en.wikipedia.org/wiki/IPv4
    if protocol == "tcp":
        tpl = communityid.FlowTuple.make_tcp(
            src_ip, dest_ip, src_port, dest_port
        )  # noqa: E501
        community_id = cid.calc(tpl)
    elif protocol == "udp":
        tpl = communityid.FlowTuple.make_udp(
            src_ip, dest_ip, src_port, dest_port
        )  # noqa: E501
        community_id = cid.calc(tpl)
    else:
        community_id = "Protocol not supported"
    return community_id


@Configuration()
class CommunityIDStreamingCommand(StreamingCommand):
    src_ip = Option(
        doc="""
        **Syntax:** **file_hash=***<file_hash>*
        **Description:** This field contains the file hash you want to search""",  # noqa: E501
        require=True,
        validate=validators.Fieldname(),
    )

    src_port = Option(
        doc="""
        **Syntax:** **file_hash=***<file_hash>*
        **Description:** This field contains the file hash you want to search""",  # noqa: E501
        require=True,
        validate=validators.Fieldname(),
    )

    dest_ip = Option(
        doc="""
        **Syntax:** **file_hash=***<file_hash>*
        **Description:** This field contains the file hash you want to search""",  # noqa: E501
        require=True,
        validate=validators.Fieldname(),
    )

    dest_port = Option(
        doc="""
        **Syntax:** **file_hash=***<file_hash>*
        **Description:** This field contains the file hash you want to search""",  # noqa: E501
        require=True,
        validate=validators.Fieldname(),
    )

    protocol = Option(
        doc="""
        **Syntax:** **protocol=***<field name that contains protocol>*
        **Description:** This field contains the file hash you want to search""",  # noqa: E501
        require=True,
        validate=validators.Fieldname(),
    )

    def stream(self, records):
        for record in records:
            src_ip = record[self.src_ip]
            src_port = record[self.src_port]
            dest_ip = record[self.dest_ip]
            dest_port = record[self.dest_port]
            protocol = record[self.protocol]
            cid = generate_community_id(
                src_ip, src_port, dest_ip, dest_port, protocol
            )  # noqa: E501

            record["community_id"] = cid
            yield record


dispatch(
    CommunityIDStreamingCommand, sys.argv, sys.stdin, sys.stdout, __name__
)  # noqa: E501
