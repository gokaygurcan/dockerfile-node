# gokaygurcan/dockerfile-node

FROM gokaygurcan/ubuntu:latest

# metadata
LABEL maintainer "Gökay Gürcan <docker@gokaygurcan.com>"

ENV DEBIAN_FRONTEND="noninteractive" \
    NS_NODE=node_10.x \
    NS_NSOLID=nsolid_3.x \
    NS_DISTRO=bionic

USER root

RUN mkdir -p /usr/src/node && \
    cd /usr/src/node && \
    # install node
    curl -sLf -o /dev/null "https://deb.nodesource.com/${NS_NODE}/dists/${NS_DISTRO}/Release" && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/${NS_NODE} ${NS_DISTRO} main" | tee /etc/apt/sources.list.d/nsolid.list && \
    echo "deb-src https://deb.nodesource.com/${NS_NODE} ${NS_DISTRO} main" | tee -a /etc/apt/sources.list.d/nsolid.list && \
    apt-get update -qq && \
    apt-get install -yqq nodejs && \
    # configure npm
    npm config list > /dev/null 2>&1 && \
    mkdir -p /home/ubuntu/.config && \
    chown -R ubuntu:$(id -gn ubuntu) /home/ubuntu/.config && \
    mkdir -p /home/ubuntu/.npm-global && \
    chown -R ubuntu:$(id -gn ubuntu) /home/ubuntu/.npm-global && \
    npm config --global set prefix /home/ubuntu/.npm-global && \
    # install yarn
    curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y yarn && \
    # install nsolid
    curl -sLf -o /dev/null "http://nsolid-deb.nodesource.com/${NS_NSOLID}/dists/${NS_DISTRO}/Release" && \
    curl -s http://nsolid-deb.nodesource.com/gpgkey/NODESOURCE-NSOLID-GPG-SIGNING-KEY | apt-key add - && \
    echo "deb http://nsolid-deb.nodesource.com/${NS_NSOLID} ${NS_DISTRO} main" | tee /etc/apt/sources.list.d/nsolid.list && \
    apt-get update -qq && \
    apt-get install -yqq nsolid-dubnium && \
    # cleanup
    apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf /usr/src/* && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

WORKDIR /home/ubuntu

USER ubuntu

CMD [ "node" ]
