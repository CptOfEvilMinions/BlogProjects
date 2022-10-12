# Splunk setup

## Docker setup
0. `openssl req -subj '/CN=localhost' -x509 -newkey rsa:4096 -nodes -keyout conf/nginx/cert/key.pem -out conf/nginx/cert/cert.pem -days 365`
0. `docker-compose up -d`
0. Browse to `https://localhost`
    1. User: admin
    1. Pass: changeme

## Ansible setup


## Supported OSes
* Ubuntu Server 18.04 64-bit

# Resources/Sources
* https://medium.com/@oliver.zampieri/self-signed-ssl-reverse-proxy-with-docker-dbfc78c05b41
* https://hub.docker.com/r/splunk/splunk/
* https://www.splunk.com/blog/2018/01/17/hands-on-lab-sandboxing-with-splunk-with-docker.html
