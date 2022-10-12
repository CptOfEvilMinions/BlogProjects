# Custom Python search command for Splun

## Local dev
1. `pip3 install -r requirements.txt --target=helloworld/lib`
1. `pip3 install -r requirements.txt --target=hybrid_analysis_cred_store_search_command/lib`
1. `pip3 install -r community_id_pip_search_command/requirements.txt --target=community_id_pip_search_command/lib`

## DEBUG custom search command from command line
1. `cd /opt/splunk/etc/apps/custom_search_command`
1. `/opt/splunk/bin/splunk cmd python /opt/splunk/etc/apps/<app_name>/bin/<python file name>.py`

## Helloworld search command
1. `index="zeek" sourcetype="bro:conn:json" | helloworld | table uid, src_ip, dest_ip, hello`

## CommunityID search command
1. `index="zeek" | communityid( dest_ip=dest_ip, dest_port=dest_port, protocol=proto, src_ip=src_ip, src_port=src_port ) | table src_ip, src_port, dest_ip, dest_port, proto, community_id`

## Hybrid Analysis hash search command
1. `index="zeek-files" | dedup sha1 | hybridanalysislookup( file_hash=sha1 ) | table sha1, hash_result`

## Supported versions
* `Splunk v8.0.7`
* `Python v3.X`

## References
* [Get current time in milliseconds in Python?](https://stackoverflow.com/questions/5998245/get-current-time-in-milliseconds-in-python)
* [Malshare - cf50bb30fbdd9319dd17ebf1e426684d](https://malshare.com/sample.php?action=detail&hash=cf50bb30fbdd9319dd17ebf1e426684d)
* [Sokunk - passwords.conf](https://docs.splunk.com/Documentation/Splunk/8.1.0/Admin/Passwords)
* [setup.xml.conf](https://docs.splunk.com/Documentation/Splunk/8.1.0/Admin/Setup.xmlconf)
* [Storing encrypted credentials](https://www.splunk.com/en_us/blog/security/storing-encrypted-credentials.html)
* [Creating a Custom Search Command with the Python SDK](https://www.youtube.com/watch?v=dc89nCWY35c&t=84s)
* [Create custom search commands for apps in Splunk Cloud or Splunk Enterprise](https://dev.splunk.com/enterprise/docs/devtools/customsearchcommands/)
* [Custom search command examples](https://dev.splunk.com/enterprise/docs/devtools/customsearchcommands/customsearchcmdexamples/)
* [Github - splunk-sdk-python/examples/searchcommands_app/package/bin/countmatches.py](https://github.com/splunk/splunk-sdk-python/blob/master/examples/searchcommands_app/package/bin/countmatches.py)
* [How do I install Splunklib for Python 3.7 on Windows?](https://stackoverflow.com/questions/59104347/how-do-i-install-splunklib-for-python-3-7-on-windows)
* [Install a Python package into a different directory using pip?](https://stackoverflow.com/questions/2915471/install-a-python-package-into-a-different-directory-using-pip)
* [splunklib.searchcommands](https://splunk-python-sdk.readthedocs.io/en/latest/searchcommands.html)
* [Types of commands](https://docs.splunk.com/Documentation/Splunk/8.1.0/Search/Typesofcommands)
* [Splunk : How to create streaming custom command using Intersplunk](https://www.youtube.com/watch?v=tJ8r_qQSu8o)
* [Storing encrypted credentials](https://www.splunk.com/en_us/blog/security/storing-encrypted-credentials.html)
* [Make Splunk Do It: How to Decrypt Passwords Encrypted by Splunk](https://hurricanelabs.com/splunk-tutorials/make-splunk-do-it-how-to-decrypt-passwords-encrypted-by-splunk/)
* [Splunk Stored Encrypted Credentials](http://www.georgestarcher.com/splunk-stored-encrypted-credentials/)
* [Splunk app - TA-VirusTotal](https://gitlab.com/adarma_public_projects/splunk/TA-VirusTotal)
* [How to fix "Could not load lookup=LOOKUP-app_proto"?](https://community.splunk.com/t5/Splunk-Search/How-to-fix-quot-Could-not-load-lookup-LOOKUP-app-proto-quot/m-p/467618)
* [JasonConger/TA_modinput_cred-example](https://github.com/JasonConger/TA_modinput_cred-example)
* [how to save username field in two endpoints in setup.xml](https://community.splunk.com/t5/Security/how-to-save-username-field-in-two-endpoints-in-setup-xml/m-p/255134)
* [HybridAnalysis - 94ff3cb078b5f679596c8b52acca06ff6ab84f6b](https://www.hybrid-analysis.com/search?query=94ff3cb078b5f679596c8b52acca06ff6ab84f6b)
* [How do I allow users to edit credentials using the setup screen?](https://community.splunk.com/t5/Getting-Data-In/How-do-I-allow-users-to-edit-credentials-using-the-setup-screen/m-p/90447)
* [splunk/TA-VirusTotal - setup.xml](https://gitlab.com/adarma_public_projects/splunk/TA-VirusTotal/-/raw/master/default/setup.xml)
