FROM		alpine:3.12.1

COPY		./srcs/* /tmp/
RUN			chmod 777 -R /tmp/*

RUN			apk update
RUN			apk add openrc telegraf  --allow-untrusted --no-cache \
				--repository https://dl-cdn.alpinelinux.org/alpine/latest-stable/community/

ENTRYPOINT	[ "/tmp/init.sh" ]
