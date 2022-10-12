#

## Generate cert for NGINX
1. `openssl req -newkey rsa:2048 -nodes -keyout conf/nginx/ssl/splunk.key -x509 -days 365 -out conf/nginx/ssl/splunk.crt`


## Referenes
* [Securing HTTP Traffic to Upstream Servers](https://docs.nginx.com/nginx/admin-guide/security-controls/securing-http-traffic-upstream/)
* [Generating a self-signed certificate using OpenSSL](https://www.ibm.com/support/knowledgecenter/en/SSMNED_5.0.0/com.ibm.apic.cmc.doc/task_apionprem_gernerate_self_signed_openSSL.html)
