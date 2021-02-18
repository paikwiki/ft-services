#! /bin/sh

if [[ ! -d /run/mysqld ]]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

chmod 444 /tmp/mariadb-server.cnf
mv -f /tmp/mariadb-server.cnf /etc/my.cnf.d/

nohup sh /tmp/init_mysql.sh &

if [[ ! -d /data/mysql ]]; then
	mkdir -p /data/mysql
	/usr/bin/mysql_install_db --user=root --datadir=/data
fi

/usr/bin/mysqld --user=root --console
