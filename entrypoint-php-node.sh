#!/bin/bash

cron
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
