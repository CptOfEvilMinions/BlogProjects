FROM ubuntu:18.04

# Update
RUN apt-get update -y

### Add Rsyslog repo ###
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:adiscon/v8-stable
RUN apt-get update -y

#### Install/Setup Ryslog ####
RUN apt-get install rsyslog rsyslog-kafka rsyslog-mmjsonparse -y

# Copy configs
COPY conf/rsyslog-server/rsyslog.conf /etc/rsyslog.conf
COPY conf/rsyslog-server/30-osquery-input.conf /etc/rsyslog.d/30-osquery-input.conf
COPY conf/rsyslog-server/31-kafka-output.conf /etc/rsyslog.d/31-kafka-output.conf

# Expose port
EXPOSE 1514/udp

# Run rsyslog
CMD ["/usr/sbin/rsyslogd", "-n", "-f", "/etc/rsyslog.conf"]
