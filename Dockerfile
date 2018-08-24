# gokaygurcan/dockerfile-node

FROM gokaygurcan/ubuntu:latest

LABEL maintainer="Gökay Gürcan <docker@gokaygurcan.com>"

ENV DEBIAN_FRONTEND="noninteractive" \
    USR_SRC_NODE=/usr/src/node \
    NS_NODE=node_8.x \
    NS_NSOLID=nsolid_3.x \
    NS_DISTRO=bionic

USER root

RUN set -ex && \
    apt-get update -qq && \
    apt-get upgrade -yqq && \
    apt-get install -yqq --no-install-recommends --no-install-suggests \
    lsb-release && \
    mkdir -p ${USR_SRC_NODE}

WORKDIR ${USR_SRC_NODE}
RUN curl -sLf -o /dev/null "https://deb.nodesource.com/${NS_NODE}/dists/${NS_DISTRO}/Release" && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/${NS_NODE} ${NS_DISTRO} main" | tee /etc/apt/sources.list.d/nodesource-node.list && \
    echo "deb-src https://deb.nodesource.com/${NS_NODE} ${NS_DISTRO} main" | tee -a /etc/apt/sources.list.d/nodesource-node.list && \
    apt-get update -qq && \
    apt-get install -y nodejs && \
    npm config list > /dev/null 2>&1 && \
    mkdir -p /home/ubuntu/.config && \
    chown -R ubuntu:$(id -gn ubuntu) /home/ubuntu/.config && \
    curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn && \
    curl -sLf -o /dev/null "http://nsolid-deb.nodesource.com/${NS_NSOLID}/dists/${NS_DISTRO}/Release" && \
    curl -s http://nsolid-deb.nodesource.com/gpgkey/NODESOURCE-NSOLID-GPG-SIGNING-KEY | apt-key add - && \
    echo "deb http://nsolid-deb.nodesource.com/${NS_NSOLID} ${NS_DISTRO} main" | tee /etc/apt/sources.list.d/nodesource-nsolid.list && \
    apt-get update && \
    apt-get install -y nsolid-carbon && \
    apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf ${USR_SRC_NODE} && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

WORKDIR /usr/bin

USER ubuntu

CMD [ "node" ]
