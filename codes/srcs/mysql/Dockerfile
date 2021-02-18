# dk build -t mysql . && dk run -it -p 3306:3306 mysql:latest

FROM		alpine:3.12.1

RUN			apk update
RUN			apk add mysql mysql-client

COPY		./srcs/init.sh /tmp/
COPY		./srcs/init_mysql.sh /tmp/
COPY		./srcs/mariadb-server.cnf /tmp/

EXPOSE		3306

ENTRYPOINT	["/tmp/init.sh"]
