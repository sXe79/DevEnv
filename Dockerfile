FROM php:7.3.16-apache

RUN apt-get update \
 && apt-get install -y \
	git \
	zip \
	vim \
  htop \
  wget \
 && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer

RUN yes | pecl install xdebug \
 && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

COPY xdebug.ini "/usr/local/etc/php/conf.d/xdebug.ini"

WORKDIR /var/www/html