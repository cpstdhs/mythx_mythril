FROM ubuntu:bionic
MAINTAINER cpstd_hs@naver.com

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl1.0-dev \
        wget \
	nodejs-dev \
	node-gyp \
	npm \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /usr/local/nvm

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.16.3
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION
ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

RUN source $NVM_DIR/nvm.sh \
	&& nvm install $NODE_VERSION \
	&& nvm alias default $NODE_VERSION \
	&& nvm use default
#	&& nvm config set user 0 \
#	&& nvm config set unsaft-perm true


#ENV MYTHX_ETH_ADDRESS 0x59e938963d7cb1b1f978c1fe5bf2c40d5a55fd32
#ENV MYTHX_PASSWORD vPdl1fhem!

RUN npm i -g truffle
RUN npm i truffle-security

RUN rm -rf /node_modules/truffle-security/integration-tests/project/contracts/*

#WORKDIR /node_modules/truffle-security/integration-tests/project/contracts

ENTRYPOINT ["/usr/local/nvm/versions/node/v10.16.3/bin/truffle"]
