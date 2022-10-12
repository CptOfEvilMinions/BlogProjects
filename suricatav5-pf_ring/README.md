# Suricata v5.0.3 + pf_ring v7.6.0
This repo contains an Ansible playbook to deploy Suricata compiled with pf_ring. This repo also contains the necessary configs for a manual/custom setup.

* [Compile Suricata v5.0.3 with PF_RING v7.6.0 on Ubuntu 20.04](https://holdmybeersecurity.com/2020/08/22/compile-suricata-v5-0-3-with-pf_ring-v7-6-0-on-ubuntu-20-04)

## Ansible
1. `vim hosts.ini`
  1. Replace `172.16.125.130` with the IP address of the host to run this playbook on
  1. Save and exit
1. `vim group_vars/sec_tools.yml`
  1. Replace `ens33` for monitoring_interface wiht the interface you want Suricata to monitor
  1. Save and exit
1. `ansible-playbook -i hosts.ini deploy_suricata_pf_ring.yml -u <user with admin perms> -K`
  1. Enter password for user

## Oprating systems
* Ubuntu Server 20.04 64-bit - Kernel version: `5.4.0-42-generic`

## References
* [apt install linux-headers-$(uname -r) in ansible](https://www.reddit.com/r/ansible/comments/bzdd7q/apt_install_linuxheadersuname_r_in_ansible/)
* [How to Install Kernel Headers in Ubuntu and Debian](https://www.tecmint.com/install-kernel-headers-in-ubuntu-and-debian/)
* [Github - ntop/PF_RING](https://github.com/ntop/PF_RING)
* [PF_RING - Installing from GIT](https://www.ntop.org/guides/pf_ring/get_started/git_installation.html)
* [How to install autoconf](https://askubuntu.com/questions/290194/how-to-install-autoconf)
* [Github issue - "libtoolize not found" - linux dependency](https://github.com/beakerbrowser/beaker/issues/54)
* [PF_RING FT (Flow Table)](https://www.ntop.org/products/packet-capture/pf_ring/pf_ring-ft-flow-table/)
* [Installation of Suricata stable with PF RING (STABLE) on Ubuntu server 12.04](https://redmine.openinfosecfoundation.org/projects/suricata/wiki/Installation_of_Suricata_stable_with_PF_RING_(STABLE)_on_Ubuntu_server_1204)
* [Detecting intruders with Suricata = ](https://www.admin-magazine.com/Articles/Detecting-intruders-with-Suricata/(offset)/3)
* [Suricata - Controlling which rules are used](https://suricata.readthedocs.io/en/suricata-5.0.3/rule-management/suricata-update.html#controlling-which-rules-are-used)
* [Suricata Update Documentation - Example Configuration File (/etc/suricata/update.yaml)](https://readthedocs.org/projects/suricata-update/downloads/pdf/latest/)
* [Github gist - Suricata v5.0.3 init.d and default config for pf_ring](https://gist.github.com/CptOfEvilMinions/5a35409d6cc57e5bc503dca8fe3413a2)
* [Suricata](https://www.cnblogs.com/zlslch/p/7382190.html)
* [Setting up the Suricata IDPS](https://ev1z.be/2016/11/27/setting-up-the-suricata-idps/)
* [Bug#839146: suricata failures with systemd](https://groups.google.com/g/linux.debian.bugs.dist/c/03x0Gt3a_y4?pli=1)
* [Github issuee - pf_ring init script doesn't load drivers after rebuilding them upon kernel update. #102](https://github.com/ntop/PF_RING/issues/102)
* [Github - hultdin/nsmfoo - 00. Suricata + Barnyard2 + Snorby == True](https://github.com/hultdin/nsmfoo)
* [nDPI - Quick Start Guide](https://www.ntop.org/wp-content/uploads/2013/12/nDPI_QuickStartGuide.pdf)
* [Ansible - apt](https://docs.ansible.com/ansible/latest/modules/apt_module.html)
* [Ansible - copy](https://docs.ansible.com/ansible/latest/modules/copy_module.html)
* [Ansible - conditionals](https://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html)
* [Ansible - Unsafe or Raw Strings](https://docs.ansible.com/ansible/latest/user_guide/playbooks_advanced_syntax.html#unsafe-or-raw-strings)
* [Ansible - getent](https://docs.ansible.com/ansible/latest/modules/getent_module.html)
* [Ansible - file](https://docs.ansible.com/ansible/latest/modules/file_module.html)
* [Ansible -sysvint](https://docs.ansible.com/ansible/latest/modules/sysvinit_module.html)
* []()
* []()
