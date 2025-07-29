FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    curl 

#We need these directories. idk why exce[t for var wdajfnafn]
RUN mkdir /run/php
RUN mkdir -p /var/www/html


RUN sed -i 's|^listen = .*|listen = wordpress:9000|g' /etc/php/7.4/fpm/pool.d/www.conf