#!/bin/sh

# mkdir -p /var/run/nginx
#   nginx pid를 생성하기 위해 필요한 명령
#   실행하지 않을 경우 "[emerg] open() "/run/nginx/nginx.pid" failed \
#   (2: No such file or directory)" 오류 발생
mv /tmp/localhost.conf /etc/nginx/conf.d/
rm /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
