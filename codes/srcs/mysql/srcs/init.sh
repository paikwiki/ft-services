#! /bin/sh

if [[ ! -d /var/run/mysqld ]]; then
	mkdir -p /var/run/mysqld
	chown -R mysql:mysql /var/run/mysqld
fi

chmod 444 /tmp/mariadb-server.cnf
mv -f /tmp/mariadb-server.cnf /etc/my.cnf.d/

nohup sh /tmp/init_mysql.sh &

if [[ ! -d /data/mysql ]]; then
	/usr/bin/mysql_install_db --user=root --datadir=/data
	/usr/bin/mysqld_safe --datadir=/data
fi
