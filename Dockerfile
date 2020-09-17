FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get install -y \
    dnsutils \
    vim \
    iputils-ping \
    net-tools \
    netcat \
    traceroute \
    curl

RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*