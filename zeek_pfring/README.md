# Zeek + PF_RING

Monitoring your home network can be challenging without enterprise-grade equipment. Although monitoring your home network can prove to be difficult, Proxmox and Zeek provide the perfect solution to monitor your home network. This blog post will cover how to setup Zeek+PF_Ring to monitor network traffic on Proxmox.

## Blog post
[Part 1: Install/Setup Zeek + pf_ring on Ubuntu 18.04 on Proxmox 5.3 + openVswitch](https://holdmybeersecurity.com/2019/04/03/part-1-install-setup-zeek-pf_ring-on-ubuntu-18-04-on-proxmox-5-3-openvswitch/)

## Install/Setup Zeek + PF_RING on Ubuntu 18.04
1. `mv group_vars/all.yml.example group_vars/all.yml`
1. `vim group_vars/all.yml` and set:
    1. general
        1. `timezone` - Set timezone for machine
    1. zeek
        1. `zeek_hostname` - Set hostname for machine
        1. `zeek_interface` - Set interface for machine
        1. `zeek_geoip` - Enable/Disable GeoIP tagging
        1. `zeek_file_extraction` - Enable/Disable file extraction
        1, `zeek_custom_scripts` - Include custom scripts
1. `mv conf/zeek/networks.cfg.example conf/zeek/networks.cfg`
1. `vim conf/zeek/networks.cfg`
```
Add network ranges in CIDR notation
10.0.0.0/8
192.168.1.0/24
```
    1. Save and exit
1. `ansible-playbook -i hosts.ini deploy_zeek_pf_ring.yml -u <user> -K`


## Resources/Sources
