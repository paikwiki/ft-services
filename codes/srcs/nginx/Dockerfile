# dk build -t nginx . && dk run -it -p 80:80 -p 22:22 nginx:latest

FROM		alpine:3.12.1

RUN			apk update
RUN			apk add openrc nginx openssh --no-cache --quiet

COPY		./srcs/init.sh /tmp/

EXPOSE		80 22

ENTRYPOINT	["/tmp/init.sh"]
