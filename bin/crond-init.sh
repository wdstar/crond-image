#!/bin/sh

cp /usr/share/zoneinfo/${TZ:-UTC} /etc/localtime
date
chown root:root /etc/cron.d/*
chmod 0644 /etc/cron.d/*
cron && echo 'Starting crond...'
while true; do sleep 600; done

