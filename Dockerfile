FROM afrith/node-xenial

RUN apt-get update && \
    apt-get install -y php7.0-fpm php7.0-mysql php7.0-sqlite php7.0-gd php7.0-bz2 php7.0-opcache supervisor cron rsyslog libhyphen0 make && \
    mkdir -p /run/php && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv ./composer.phar /usr/bin/composer

#ADD etc/crontab /etc/crontabs/node
ADD supervisord.conf /etc/supervisor/conf.d/
ADD entrypoint-php-node.sh /entrypoint-php-node.sh
ADD etc/php/pool.conf /etc/php/7.0/fpm/pool.d/www.conf
ADD provision-on-deployment.sh /provision-on-deployment.sh

RUN chmod +x /entrypoint-php-node.sh && chmod +x /provision-on-deployment.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint-php-node.sh"]
