#

## Generate cert for NGINX
1. `openssl req -newkey rsa:2048 -nodes -keyout conf/nginx/ssl/splunk.key -x509 -days 365 -out conf/nginx/ssl/splunk.crt`


## Referenes
* [Github - CptOfEvilMinions/ThreatWaffle](https://github.com/CptOfEvilMinions/ThreatWaffle/)
* [Anisble - win_service](https://docs.ansible.com/ansible/latest/modules/win_service_module.html)
* [Osquery - extensions](https://osquery.readthedocs.io/en/stable/deployment/extensions/)
* [Github - polylogyx/osq-ext-bin](https://github.com/polylogyx/osq-ext-bin)
* [Ansible - win_chocolately](https://docs.ansible.com/ansible/latest/modules/win_chocolatey_module.html)
* [USING ANSIBLE TO INSTALL A CHOCOLATEY PACKAGE REPOSITORY](https://www.frostbyte.us/using-ansible-to-install-a-chocolatey-package-repository/)
* [Ansible - win_unzip](https://docs.ansible.com/ansible/latest/modules/win_unzip_module.html)
* [Ansible - win_get_url](https://docs.ansible.com/ansible/latest/modules/win_get_url_module.html)
* [Ansible - win_copy](https://docs.ansible.com/ansible/2.4/win_copy_module.html)
* [Ansible - win_shell](https://docs.ansible.com/ansible/latest/modules/win_shell_module.html)
* [Logstash - Replace double backslashes // with one / in a string](https://discuss.elastic.co/t/replace-double-backslashes-with-one-in-a-string/165858/4)
* [Github - dennybritz/docker-splunk](https://github.com/dennybritz/docker-splunk/blob/master/enterprise/README.md)
