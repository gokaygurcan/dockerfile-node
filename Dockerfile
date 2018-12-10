# gokaygurcan/dockerfile-node

FROM gokaygurcan/ubuntu:latest

# metadata
LABEL maintainer = "Gökay Gürcan <docker@gokaygurcan.com>"
LABEL com.gokaygurcan.project.name = "dockerfile-node"
LABEL com.gokaygurcan.project.version = "1.2.2"
LABEL org.label-schema.name = "dockerfile-node"
LABEL org.label-schema.description = "Node.js with npm, Yarn and N|Solid."
LABEL org.label-schema.vcs-url = "https://github.com/gokaygurcan/dockerfile-node"
LABEL org.label-schema.vendor = "gokaygurcan"
LABEL org.label-schema.version = "1.2.2"
LABEL org.label-schema.schema-version = "1.0"

ENV DEBIAN_FRONTEND="noninteractive" \
    USR_SRC_NODE=/usr/src/node \
    NS_NODE=node_10.x \
    NS_NSOLID=nsolid_3.x \
    NS_DISTRO=bionic

USER root

RUN mkdir -p ${USR_SRC_NODE}

WORKDIR ${USR_SRC_NODE}
RUN curl -sLf -o /dev/null "https://deb.nodesource.com/${NS_NODE}/dists/${NS_DISTRO}/Release" && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/${NS_NODE} ${NS_DISTRO} main" | tee /etc/apt/sources.list.d/nodesource-node.list && \
    echo "deb-src https://deb.nodesource.com/${NS_NODE} ${NS_DISTRO} main" | tee -a /etc/apt/sources.list.d/nodesource-node.list && \
    apt-get update -qq && \
    apt-get install -yqq nodejs && \
    npm config list > /dev/null 2>&1 && \
    mkdir -p /home/ubuntu/.config && \
    chown -R ubuntu:$(id -gn ubuntu) /home/ubuntu/.config && \
    mkdir -p /home/ubuntu/.npm-global && \
    chown -R ubuntu:$(id -gn ubuntu) /home/ubuntu/.npm-global && \
    npm config --global set prefix /home/ubuntu/.npm-global && \
    curl -s https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y yarn && \
    curl -sLf -o /dev/null "http://nsolid-deb.nodesource.com/${NS_NSOLID}/dists/${NS_DISTRO}/Release" && \
    curl -s http://nsolid-deb.nodesource.com/gpgkey/NODESOURCE-NSOLID-GPG-SIGNING-KEY | apt-key add - && \
    echo "deb http://nsolid-deb.nodesource.com/${NS_NSOLID} ${NS_DISTRO} main" | tee /etc/apt/sources.list.d/nodesource-nsolid.list && \
    echo "deb-src http://nsolid-deb.nodesource.com/${NS_NSOLID} ${NS_DISTRO} main" | tee -a /etc/apt/sources.list.d/nodesource-nsolid.list && \
    apt-get update -qq && \
    apt-get install -yqq nsolid-dubnium && \
    apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf ${USR_SRC_NODE} && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

WORKDIR /usr/bin

USER ubuntu

CMD [ "node" ]
