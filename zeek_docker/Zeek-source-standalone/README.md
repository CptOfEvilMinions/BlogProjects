# Zeek from source

## Build Zeek
1. `docker build -f Dockerfile-zeek-build -t zeek-build .`

## Run Zeek standalone
### Get interface on host
1. Run on host: `ip a`
    1. Copy interface name you want to monitor

## Build container
1. `cd BlogProjects/zeek_docker`
1. `docker build -f Zeek-source-standalone/Dockerfile --build-arg zeek_interface=<interface to monitor on host> -t zeek-source-standalone .`

## Spin up container
1. `cd Zeek-mirror`
1. `docker-compose up -d`

## Debugging
1. `docker run -it --net=host zeek-source-standalone bash`
