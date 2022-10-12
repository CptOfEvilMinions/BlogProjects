# PoC: Monitoring user browser activity with Osquery

*  Blog post: [PoC: Monitoring user browser activity with Osquery](https://holdmybeersecurity.com/2019/10/06/poc-monitoring-user-browser-activity-with-osquery/)

This proof-of-concept (PoC) will demonstrate how to use Osquery to monitor the browser activity of users.  Not only will this PoC collect browser activity, but it will also use VirusTotal to rank each URL to detect malicious activity. In addition to VirusTotal, this PoC will utilize Rsyslog, Osquery, Kafka, Splunk,  Virustotal, Python3, and Docker as a logging pipeline. Once this pipeline has been implemented your security team will have the ability to protect your user's from today's most serious threats on the web.

## Local dev
1. `virtualenv -p python3 venv`
1. `source venv/bin/activate`
1. `pip3 install -r app/requirements.txt`

## Deploy stack
1. `docker-compose up -d`


## References
* [How to get the current time in Python](https://stackoverflow.com/questions/415511/how-to-get-the-current-time-in-python)
* [Python configparser.ConfigParser() Examples](https://www.programcreek.com/python/example/61082/configparser.ConfigParser)
* [Github - confluentinc/confluent-kafka-python](https://github.com/confluentinc/confluent-kafka-python)
* [Kafka Listeners - Explained](https://rmoff.net/2018/08/02/kafka-listeners-explained/)
* [Github - confluentinc/cp-docker-images: kafka-single-node/docker-compose.yml](https://github.com/confluentinc/cp-docker-images/blob/5.3.1-post/examples/kafka-single-node/docker-compose.yml)
* [Github - Landoop/kafka-cheat-sheet](https://github.com/Landoop/kafka-cheat-sheet)
* [imkafka: read from Apache Kafka](https://www.rsyslog.com/doc/v8-stable/configuration/modules/imkafka.html)
