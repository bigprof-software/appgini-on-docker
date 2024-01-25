FROM php:8.3-apache

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN a2enmod rewrite remoteip setenvif

# Install mysql-client
RUN apt-get update && apt-get install -y default-mysql-client

# https://github.com/mlocati/docker-php-extension-installer
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd mysqli imagick zip ldap