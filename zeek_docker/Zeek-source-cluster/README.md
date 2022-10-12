# Zeek from source stack setup

## Generate SSH keys
1. `cd BlogProjects/zeek_docker/Zeek-source-cluster`
1. `ssh-keygen -f .ssh/id_rsa -t rsa -N ''`

## Run Zeek stack
1. Run on host: `ip a`
    1. Copy interface name you want to monitor

## Create docker network

## Build containers
1. `docker build -f Dockerfile-zeek-cluster-manager --build-arg zeek_interface=<interface to monitor on host> -t zeek-cluster-manager .`
1. `docker build -f Dockerfile-zeek-cluster-proxy --build-arg zeek_interface=<interface to monitor on host> -t zeek-cluster-proxy .`
1. `docker build -f Dockerfile-zeek-cluster-manager --build-arg zeek_interface=<interface to monitor on host> -t zeek-cluster-worker .`


## Resources/Sources
