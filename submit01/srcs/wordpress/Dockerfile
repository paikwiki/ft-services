FROM 		alpine:3.12.1

RUN 		apk update
RUN			apk add nginx php7-common php7-iconv php7-json php7-gd \
			php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi \
			php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix \
			php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
RUN			apk add php7-fpm php7-session php7-mbstring

COPY		./srcs/init.sh /tmp/
COPY		./srcs/localhost.conf /tmp/
COPY		./srcs/wordpress-5.5.3.tar.gz /tmp/

EXPOSE		5050

ENTRYPOINT	[ "/tmp/init.sh" ]
