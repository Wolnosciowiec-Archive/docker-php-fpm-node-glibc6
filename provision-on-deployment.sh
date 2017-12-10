#!/bin/bash

echo "php-fpm > setting write permissions for the Docker user "
chown node:node /www -R

echo "php-fpm > /provision-on-deployment.sh"

for app in /www/*/; do
    if [[ -f $app/Makefile ]]; then
        su node -c "cd $app/ && make deploy"
    else
        su node -c "cd $app/ && composer install --dev"
    fi
done
