# dk build -t phpmyadmin . && dk run -it -p 80:80 phpmyadmin:latest

FROM alpine:3.12.1

RUN apk update
# from "https://wiki.alpinelinux.org/wiki/PhpMyAdmin"
RUN apk add nginx php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
# Additional
RUN apk add php7-fpm php7-session

COPY	./srcs/init.sh /tmp/
COPY	./srcs/localhost.conf /tmp/
COPY	./srcs/config.inc.php /tmp/
COPY	./srcs/phpMyAdmin-5.0.4-all-languages.tar.gz /tmp/

EXPOSE 80 5000

ENTRYPOINT [ "/tmp/init.sh" ]
