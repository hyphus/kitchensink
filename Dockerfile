FROM --platform=linux/amd64 ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=host.docker.internal:0
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LANG_ALL=en_US.UTF-8

RUN apt update && \
    apt upgrade -y && \
    apt install --no-install-recommends -y \
    apt-transport-https \
    awscli \
    bash-completion \
    build-essential \
    ca-certificates \
    cifs-utils \
    curl \
    dnsutils \
    file \
    freerdp2-x11 \
    git \
    gnupg-agent \
    grep \
    htop \
    iputils-ping \
    jq \
    ldap-utils \
    locales \
    net-tools \
    netcat \
    nfs-common \
    openssl \
    proxychains4 \
    python3 \
    python3-pip \
    smbclient \
    software-properties-common \
    ssh \
    tmux \
    tree \
    tzdata \
    unzip \
    vim \
    whois \
    x11-utils \
    xclip \
    zip && \
    rm -rf /var/lib/apt/lists/*

COPY ./proxychains.conf /etc/proxychains.conf

COPY ./install.sh /tmp/install.sh

RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm -rf /tmp/*

WORKDIR /root/

CMD [ "tmux" ]