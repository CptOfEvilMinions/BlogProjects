# Generating CommunityIDs with Sysmon and Winlogbeat

## Verify script
1. Search `event.code: 3` within the `sysmon-*` index
1. Download the data as a CSV from Kibana
1. `pip3 install -r requirements.txt`
1. `python3 verify_community_id.py --file <file path to CSV>`

## References
* [Github - SwiftOnSecurity/sysmon-config](https://github.com/SwiftOnSecurity/sysmon-config)
* [Winlogbeat - Add Tags](https://www.elastic.co/guide/en/beats/winlogbeat/current/add-tags.html)
* [Community ID Network Flow Hash](https://www.elastic.co/guide/en/beats/filebeat/current/community-id.html#community-id)
* [Winlogbeat Reference [7.7] » Configure Winlogbeat » Configure SSL](https://www.elastic.co/guide/en/beats/winlogbeat/current/configuration-ssl.html#_verification_mode)
* [Python JSON](https://www.programiz.com/python-programming/json)
