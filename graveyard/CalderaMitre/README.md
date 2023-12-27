# Caldera
## Ansible setup - prod
0. vim hosts and set [caldera]
0. mv group_vars/all.example group_vars/all
0. vim group_vars/all and set:
    1. base_domain
    1. caldera_pass
0. Create a DNS entry on your DNS server for {{ caldera_pass }}.{{ base_domain }}
0. ansible-playbook -i hosts deploy_caldera.yml -u <user>

## Docker setup - dev
0. docker build -t caldera .
0. docker run -d -p 8888:8888 --hostname=<FQDN> caldera
    1. A DNS entry MUST be made to point at the host running the Docker container. By default Caldera uses the hostname of the Docker container which is only accessible within the Docker network.

## Deploy Caldera agents to Windows
0. vim hosts and set [win_agents]
0. mv group_vars/windows.example group_vars/windows
0. vim group_vars/windows and set:
    1. ansible_user: <Windows username>
    1. ansible_password: <Windows user password>
0. ansible-playbook -i hosts deploy_windows_agents.yml



## Supported OSes for Ansible
* Ubuntu Server 16.04 64-bit

# To do:

# Resources/Sources
* https://caldera.readthedocs.io/en/latest/installation.html
* https://github.com/mitre/caldera
