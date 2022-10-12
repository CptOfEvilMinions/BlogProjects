# Graylog v3

## Blog post
[Install/Setup Graylog 3 on Ubuntu 18.04 - Zeeks logs + threat intel pipeline](https://holdmybeersecurity.com/2019/03/27/install-setup-graylog-3-on-ubuntu-18-04-zeeks-logs-threat-intel-pipeline/)

## Install/Setup Graylog
1. `git clone https://github.com/CptOfEvilMinions/BlogProjects.git`
1. `cd BlogProjects/Graylogv3`

### Docker
1. `docker-compose up -d`

### Ansible
1. `vim hosts.ini` and set:
    1. `ansible_host` - Set to the IP addr for Graylog
1. `mv group_vars/all.yml.example group_vars/all.yml`
1. `vim group_vars/all.yml` and set:
    1. `base_domain` - Set the domain for `graylog`
    1. `timezone` - Set country/state for NTP(time)
    1. `cert stuff for OpenSSL cert` - cert_*
1. `mv group_vars/graylog.yml.example group_vars/graylog.yml`
1. `vim group_vars/graylog.yml` and set:
    1. `graylog_hostname` - Set hostname for the new graylog box
    1. `graylog_admin_password` - Admin password for Graylog webgui
    1. `graylog_beats_logging` - Enable/Disable logging via Beats
        1. `graylog_beats_port` - Port to ingest Beats logs
    1. `graylog_syslog_tcp_logging` - Enable/Disable logging via Syslog with TCP
        1. `graylog_syslog_tcp_port` - Port to ingest Syslog with TCP
    1. `graylog_syslog_udp_logging` - Enable/Disable logging via Syslog with UDP
        1. `graylog_syslog_udp_port` - Port to ingest Syslog with UDP
1. `ansible-playbook -i host.ini deploy_graylog.yml -u <username> -K`

## Install/Setup logging clients
1. `mv group_vars/logging.yml.example group_vars/logging.yml`

## Install/Setup Filebeat for Zeek logs
1. `vim hosts.ini` and set:
    1. `ansible_host` - Set to the IP addr for `filebeat-agents`
1. `vim group_vars/logging.yml` and set:
    1. `zeek_log_dir` - Directory where Zeek logs are stored
1. `ansible-playbook -i host.ini deploy_filebeat_zeek.yml -u <username> -K`

## Install/Setup Rsyslog for NGINX logs
1. `vim hosts.ini` and set:
    1. `ansible_host` - Set to the IP addr for `rsyslog-agents`
1. `vim group_vars/logging.yml` and set:
    1. `nginx_log_dir` - Directory where NGINX logs are stored
1. `ansible-playbook -i host.ini deploy_rsyslog_nginx.yml -u <username> -K`

## Resources/Sources
* [How To Create a Self-Signed SSL Certificate for Nginx in Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04)
* [Redirect HTTP to HTTPS in Nginx](https://serversforhackers.com/c/redirect-http-to-https-nginx)
* [How does the web interface connect to the Graylog server?](https://docs.graylog.org/en/3.0/pages/configuration/web_interface.html#configuring-webif-nginx)
* [Ubuntu installation](https://docs.graylog.org/en/3.0/pages/installation/os/ubuntu.html)
* [Graylog - Web interface for NGINX](https://docs.graylog.org/en/3.0/pages/configuration/web_interface.html#nginx)
* [How To Set Up a Firewall with UFW on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04)
* [Enable HTTP/2 in Nginx](https://ma.ttias.be/enable-http2-in-nginx/)
* [Our Biggest and Baddest Yet: Graylog 3.0](https://www.graylog.org/products/latestversion)
