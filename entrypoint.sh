#!/bin/sh
printenv | grep -v "no_proxy" >> /etc/environment
touch /etc/cron.d/portainercron
echo "$CRON /app/script.sh >> /app/log 2>&1" > /etc/cron.d/portainercron
chmod 0644 /etc/cron.d/portainercron
crontab /etc/cron.d/portainercron
su appuser
echo "CA MARCHE POGGERS"
cron -f