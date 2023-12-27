# Ansible Google Grr server
0. mv group_vars/all.example group_vars/all
0. vim hosts and set [google_grr]
0. vim group_vars/all and set:
    1. base_domain
    1. grr_hostname
    1. timezone
    1. cert info
0. mv group_vars/grr.example group_vars/grr
0. vim group_vars/grr and set:
    1. mysql_root_password
    1. mysql_grr_user
    1. mysql_grr_pass
    1. grr_password
    1. email settings(optional)
0. ansible-playbook -i hosts deploy_grr.yml -u <username>

# Ansible Google Grr agents

## Supported OSes
* Ubuntu Server 16.04 64-bit
