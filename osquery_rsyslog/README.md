# OSquery + Rsyslog

![heart](.img/heart.png)

## Blog post
https://holdmybeersecurity.com/2019/03/29/logging-osquery-with-rsyslog-v8-love-at-first-sight/

This blog post is going to cover how to ingest OSquery logs with Rsyslog v8. Most setups I have come across have Rsyslog ingesting the logs from disk but this setup will ingest logs via the system journal. OSquery supports writing logs to disk and to the system journal. This post also contains a setup via Ansible and a manual walkthrough. Lastly, explanations of Rsyslog and OSquery configs.

## Install/Setup Rsyslog server on Ubuntu 18.04
1. `git clone https://github.com/CptOfEvilMinions/BlogProjects.git`
1. `cd BlogProjects/osquery_rsyslog`
1. `vim hosts.ini` and set IP address under `rsyslog-server`
1. `mv group_vars/all.yml.example group_vars/all.yml` and set:
    1. `slack_token` - OPTIONAL for Slack notifications
    1. `slack_channel` - OPTIONAL for Slack notifications
1. `mv group_vars/logging.yml.example group_vars/logging.yml`
    1. `rsyslog_host` - FQDN/IP address of Rsyslog server
    1. `rsyslog_port` - Port to ingest logs
    1. `rsyslog_input_module` - Module for Rsyslog to ingest logs
        1. Default set to `imrelp`
    1. `rsyslog_output_module` - Module for Rsyslog to send logs
        1. Default set to `omrelp`
        1. If using RELP for ingesting/sending logs you can enable TLS with `rsyslog_tls`
1. `ansible-playbook -i hosts.ini deploy_rsyslog_server.yml -u <username> -K`

## Install/Setup Rsyslog + OSquery client on Ubuntu 18.04
1. `vim hosts.ini` and set IP address under `rsyslog-client`
1. `ansible-playbook -i hosts.ini deploy_rsyslog_osquery_client.yml -u <username> -K`


## Verify setup
### Rsyslog server
1. `systemctl status rsyslog` - Check if Rsyslog is running
1. `rsyslogd -N 1` - Rsyslog syntax check on configs
1. `netstat -tnlp` - Check if Rsyslog is listening
1. `cd /var/log/rsyslog && ls` - Does this directory contain logs
1. `cat /var/log/rsyslog/<ubuntu>/osquery/<year>/<month>/<date>/osquery.log` - OSquery log from remote host
1. `tcpdump port 1514` - Check connection between server and client

### Rsyslog + OSquery client
1. `systemctl status rsyslog` - Check if Rsyslog is running
1. `rsyslogd -N 1` - Rsyslog syntax check on configs
1. `systemctl status osqueryd` - Check if OSquery is running
1. `cat /var/log/osquery/osqueryd.results.log` - Check if OSquery is writing logs
1. `tcpdump port 1514` - Check connection between server and client


## Supported OSes
* Ubuntu Server 18.04 64-bit

## Resources/Sources
