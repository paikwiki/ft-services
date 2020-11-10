# dk build -t nginx . && dk run -it -p 80:80 -p 22:22 nginx:latest

FROM alpine:3.12.1

RUN		apk update
RUN		apk add nginx openssh-server

COPY	./srcs/index.html /var/lib/nginx/html/
COPY	./srcs/init.sh /tmp/
COPY	./srcs/localhost.conf /tmp/

EXPOSE	80 22

ENTRYPOINT ["/tmp/init.sh"]
