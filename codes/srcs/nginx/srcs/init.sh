#!/bin/sh

mkdir -p /var/run/nginx
mv /tmp/localhost.conf /etc/nginx/conf.d/
rm /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
