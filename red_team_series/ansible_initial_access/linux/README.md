# Linux deployment

## Initial setup
0. pip install ansible

## Set hosts
0. vim hosts and add IP addresses of remote machines under "[linux_webserver]" and "[linux_ftp]"
    1. If you are only targeting one set of machines then ignore that section

## Set credentials
0. vim group_vars/linux.yml and set:
    1. ansible_user - Username for remote linux machine
    1. ansible_password - Password for remote linux machine

## Set commands
0. vim cmd/malicious_commands
    1. Ansible will run a command on each new line
        2. Any line that starts with a "#" is treated as a comment

## Run playbook
0. ansible-playbook -i hosts deploy_windows_mawlware.yml

# Resources/Sources
* https://medium.com/the-sysadmin/managing-windows-machines-with-ansible-60395445069f
