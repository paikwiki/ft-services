#!/bin/sh

ssh-keygen -A
adduser --disabled-password admin
echo "admin:password" | chpasswd

# mv /tmp/localhost.conf /etc/nginx/conf.d/
# mv /tmp/proxy.conf /etc/nginx/conf.d/
# rm /etc/nginx/conf.d/default.conf

# /usr/sbin/sshd
rc-status && touch /run/openrc/softlevel
rc-service sshd start

# mkdir -p /var/run/nginx
#   nginx pid를 생성하기 위해 필요한 명령
#   실행하지 않을 경우 "[emerg] open() "/run/nginx/nginx.pid" failed \
#   (2: No such file or directory)" 오류 발생
if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi

nginx -g "daemon off;"
