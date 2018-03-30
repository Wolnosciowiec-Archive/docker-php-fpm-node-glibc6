FROM afrith/node-xenial

RUN set -x && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    LC_ALL=C.UTF-8 add-apt-repository -y -u ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y chromium-browser chromium-chromedriver php7.1-fpm php7.1-mysql php7.1-sqlite3 sqlite3 php7.1-mbstring php7.1-json php7.1-zip php7.1-gd php7.1-bz2 php7.1-opcache supervisor cron rsyslog libhyphen0 make ssh git && \
    apt-get clean -y && \
    mkdir -p /run/php && \
    mkdir -p /home/node -p && \
    chown node:node /home/node -R && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv ./composer.phar /usr/bin/composer

#ADD etc/crontab /etc/crontabs/node
ADD supervisord.conf /etc/supervisor/conf.d/
ADD entrypoint-php-node.sh /entrypoint-php-node.sh
ADD etc/php/pool.conf /etc/php/7.1/fpm/pool.d/www.conf
ADD provision-on-deployment.sh /provision-on-deployment.sh

RUN chmod +x /entrypoint-php-node.sh && chmod +x /provision-on-deployment.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint-php-node.sh"]
