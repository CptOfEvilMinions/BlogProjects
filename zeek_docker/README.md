# Zeek + Docker

## Warning
THIS DOES NOT WORK ON MacOS!!!!!

## Different setup flavors
This repo contains different flavors of setups for Zeek. This repo contains three flavors which are: Zeek installed from a mirror, Zeek installed from source, and Zeek installed from source with PF_RING.

### Zeek installed from a mirror
This option uses Ubuntu 16.04 and installs Zeek from the OpenSuse repositories. This option is quicker to get Zeek up and running but the BRO version is older. It is recommended to install Zeek from source AND NOT a mirror.

### Zeek installed from source
This option uses Ubuntu 18.04 and compiles Zeek from source. This option takes longer to get Zeek up and running but is the most up-to-date option. It is recommended to compile Zeek from source which allows for additional functionality such as GeoIP tagging.

### Standalone vs. cluster
Zeek is NOT multithreaded, so once the limitations of a single processor core are reached the only option currently is to spread the workload across many cores, or even many physical computers. Zeek can run as single process that collects traffic and analyzes or is distributed(stack).

The distributed mode allows the Zeek process to be split up into three main components: manager, proxy, and worker. The worker collects all traffic from interface and runs it through the Zeek engine. The proxy helps maintain state and variables across multiple platforms. The manager controls all of this and collects all the logs from the workers and proxy.

Depending on the size of your network you may wish to stay with the simple standalone model. However, if you your network is large in size you may want to distribute the Zeek work load.


## Build Zeek
1. `docker build -f Dockerfile-zeek-build -t zeek-build .`
    1. This will create a 4GB image


## Supported OSes
* Ubuntu Server 18.04 64-bit

## Resources/Sources

### PF_RING
* [Using PF_RING with Docker](https://www.ntop.org/guides/pf_ring/vm_support/docker.html)

### Zeek
* [How to Monitor Network Traffic with Virtualized Bro 2.51 on Ubuntu 16.04.2 on ESXi 6.5](https://www.blackhillsinfosec.com/monitor-network-traffic-virtualized-bro-2-51-ubuntu-16-04-2-esxi-6-5/)
* [Binary Packages for Zeek Releases](https://www.zeek.org/download/packages.html)

### Docker
* [Docker ENTRYPOINT & CMD: Dockerfile best practices](https://medium.freecodecamp.org/docker-entrypoint-cmd-dockerfile-best-practices-abc591c30e21)
* [Understanding Docker Build Args, Environment Variables and Docker Compose Variables](https://vsupalov.com/docker-env-vars/)
