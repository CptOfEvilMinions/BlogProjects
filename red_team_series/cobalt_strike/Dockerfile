FROM ubuntu:18.04

# docker hardcoded sh...
SHELL ["/bin/bash", "-c"]

##### Install Java #####
RUN apt-get update -y && apt-get install -y software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update -y
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install oracle-java8-installer ca-certificates oracle-java8-set-default unzip -y

##### Setup Cobalt Strike #####
COPY files/cobaltstrike.zip /opt/cobaltstrike.zip
RUN cd /opt && unzip /opt/cobaltstrike.zip
WORKDIR /opt/cobaltstrike

##### Expose ports #####
EXPOSE 53/udp 80 443 8080 50050

##### Run Cobalt Strike #####
ENTRYPOINT ["./teamserver"]
