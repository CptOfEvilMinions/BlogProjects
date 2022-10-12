# flake8: noqa
# pylint: skip-file
#!/usr/bin/env python
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "lib"))
import time

import requests
import splunk.entity as entity
from splunklib.client import Service, StoragePassword
from splunklib.searchcommands import (
    Configuration,
    Option,
    StreamingCommand,
    dispatch,
    validators,
)

# Configurable values
API_KEY = None


def get_threat_score(hybrid_analysis_api_key, file_hash):
    """
    Input: Takes in a file hash (Md5, sha1, sha256)
    Output: Returns the threat score from Hybrid Analysis
    """
    headers = {
        "accept": "application/json",
        "user-agent": "Falcon Sandbox",
        "Content-Type": "application/x-www-form-urlencoded",
        "api-key": hybrid_analysis_api_key,
    }
    params = (("_timestamp", str(round(time.time() * 1000))),)

    data = {"hash": file_hash}

    url = "https://www.hybrid-analysis.com/api/v2/search/hash"
    r = requests.post(url=url, headers=headers, params=params, data=data)

    # Iterate over several threat scores
    with open("/tmp/hash-result.txt", "w") as f:
        f.write(str(r.json()))

    threat_score = 0
    if len(r.json()) > 0:
        for malware in r.json():
            if (
                malware["threat_score"] is not None
                and malware["threat_score"] > threat_score
            ):
                threat_score = malware["threat_score"]
        return f"{threat_score}/100"

    if len(r.json()) == 0:
        return "No results"

    return f"{r.json()[0]['threat_score']}/100"


@Configuration()
class HybridAnalysisStreamingCommand(StreamingCommand):
    file_hash = Option(
        doc="""
        **Syntax:** **file_hash=***<file_hash>*
        **Description:** This field contains the file hash you want to search""",
        require=True,
        validate=validators.Fieldname(),
    )

    def prepare(self):
        """
        Called by splunkd before the command executes.
        Used to get configuration data for this command from splunk.
        :return: None
        https://gitlab.com/adarma_public_projects/splunk/TA-VirusTotal/-/blob/master/bin/virustotal.py
        """
        global API_KEY

        # Get the API key from Splunkd's REST API
        # Also get proxy password if configured
        for passwd in self.service.storage_passwords:  # type: StoragePassword
            if (
                passwd.realm is None or passwd.realm.strip() == ""
            ) and passwd.username == "hybridanalysis":
                API_KEY = passwd.clear_password

        # Verify we got the key
        if API_KEY is None or API_KEY == "defaults_empty":
            self.error_exit(
                None,
                "No API key found for HybridAnalysis. Re-run the app setup for the TA.",
            )

    def stream(self, records):
        for record in records:
            record["hash_result"] = get_threat_score(API_KEY, record[self.file_hash])
            yield record


dispatch(HybridAnalysisStreamingCommand, sys.argv, sys.stdin, sys.stdout, __name__)
