#!bin/sh

# https://wordpress.org/wordpress-5.5.3.tar.gz
tar -xf /tmp/wordpress-5.5.3.tar.gz -C /tmp/
mv -f /tmp/wordpress /var/www/

mv /tmp/localhost.conf /etc/nginx/conf.d/
rm /etc/nginx/conf.d/default.conf

if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi

if [[ ! -d /run/mysqld ]]; then
	mkdir -p /run/mysqld
fi

# mysql -uroot -ppassword << EOF
# FLUSH PRIVILEGES;
# CREATE DATABASE IF NOT EXISTS wordpress;
# CREATE USER 'wordpress'@'%' IDENTIFIED BY 'password';
# GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' WITH GRANT OPTION;
# EOF

adduser --no-create-home -D wordpress
echo "wordpress:password" | chpasswd
chmod -R 755 /var/www/
chown -R wordpress:wordpress /var/www/wordpress

php-fpm7 & nginx -g "daemon on;"
sh
