FROM circleci/php:7.1-cli

LABEL maintainer="wade@iwader.co.uk"

ENV NVM_VERSION v0.33.2
ENV NVM_DIR /home/circleci/.nvm

# Required to add yarn package repository
RUN sudo apt-get install apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN sudo apt-get update && sudo apt-get install -y \
        libmcrypt-dev \
        git \
        unzip \
        wget \
        libpng-dev \
        libsqlite3-dev \
        libgconf-2-4 \
        libfontconfig1 \
        chromium \
        xvfb \
        yarn

RUN sudo docker-php-ext-install -j$(nproc) mcrypt pdo_mysql pdo_sqlite gd zip

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash

COPY ./scripts ./scripts

RUN sudo ./scripts/composer.sh
