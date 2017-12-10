FROM afrith/node-xenial

RUN apt-get update && apt-get install -y php7.0-fpm supervisor cron rsyslog libhyphen0 make && mkdir -p /run/php

#ADD etc/crontab /etc/crontabs/node
ADD supervisord.conf /etc/supervisor/conf.d/
ADD entrypoint-php-node.sh /entrypoint-php-node.sh
ADD etc/php/pool.conf /etc/php/7.0/fpm/pool.d/www.conf

RUN chmod +x /entrypoint-php-node.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint-php-node.sh"]
