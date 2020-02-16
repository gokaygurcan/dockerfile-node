# gokaygurcan/dockerfile-node

FROM gokaygurcan/ubuntu:latest

# metadata
LABEL maintainer "Gökay Gürcan <docker@gokaygurcan.com>"

ENV DEBIAN_FRONTEND="noninteractive"
ENV NVM_DIR="/home/ubuntu/.nvm"

ARG NODE_VERSION=12.16.0
ENV NODE_VERSION=$NODE_VERSION

USER root

# update
RUN apt-get update -qq && \
    apt-get upgrade -yqq

USER ubuntu

# install node version manager
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# add node and npm to PATH
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

USER root

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -yqq yarn

# cleanup
RUN apt-get autoclean -yqq && \
    apt-get autoremove -yqq && \
    rm -rf /usr/src/* && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

USER ubuntu

WORKDIR /home/ubuntu

CMD [ "node" ]
