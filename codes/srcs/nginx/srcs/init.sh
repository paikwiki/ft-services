#!/bin/sh

ssh-keygen -A
adduser --disabled-password admin
echo "admin:password" | chpasswd

ln -s /var/www/conf_dir/index.html /var/www/index.html

# mkdir -p /var/run/nginx
#   nginx pid를 생성하기 위해 필요한 명령
#   실행하지 않을 경우 "[emerg] open() "/run/nginx/nginx.pid" failed \
#   (2: No such file or directory)" 오류 발생
if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi

nginx -g "daemon off;"
