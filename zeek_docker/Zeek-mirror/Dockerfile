FROM ubuntu:18.04

# Build args
ARG zeek_interface=eth0

# Update
RUN apt-get update -y && apt-get install wget net-tools supervisor gnupg -y

# Get Zeek GPG key
RUN wget -nv http://download.opensuse.org/repositories/network:bro/xUbuntu_14.04/Release.key -O Release.key
RUN apt-key add - < Release.key
RUN apt-get update
RUN apt-key add - < Release.key

# Install Zeek
RUN sh -c "echo 'deb http://http://download.opensuse.org/repositories/network:/bro/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/bro.list"
RUN apt-get update -y && apt-get install bro -y

# Add configs
COPY conf/bro/node-standalone.cfg /opt/bro/etc/node.cfg

# Change default interface
RUN sed -i "s/interface=eth0/interface=$zeek_interface/g" /opt/bro/etc/node.cfg

# Supervisor
COPY conf/supervisor/supervisor.conf /etc/supervisor/conf.d/supervisord.conf

# Entrypoint
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
