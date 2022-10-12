FROM ubuntu:18.04

# Add user
RUN useradd -ms /bin/bash appuser

# Install things
RUN apt-get update -y && apt-get install python3 python3-pip python3-dev gcc -y

# Copy application
RUN mkdir /kafka-enricher
COPY app /kafka-enricher/app
COPY config /kafka-enricher/config
COPY run_server.py /kafka-enricher/run_server.py
COPY requirements.txt /kafka-enricher/requirements.txt

RUN chown appuser:appuser -R /kafka-enricher

# Install python modules
RUN cd /kafka-enricher && pip3 install -r requirements.txt

USER appuser

WORKDIR /kafka-enricher

CMD ["python3", "-u", "run_server.py"]
