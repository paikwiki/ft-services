#!bin/sh

# https://wordpress.org/wordpress-5.5.3.tar.gz
# tar -xf /tmp/wordpress-5.5.3.tar.gz -C /tmp/
# mv -f /tmp/wordpress /var/www

mv -f /tmp/wordpress-5.5.3.tar.gz /var/www/
tar -xf /var/www/wordpress-5.5.3.tar.gz -C /var/www/

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

adduser --no-create-home -D admin
echo "admin:password" | chpasswd
chmod -R 755 /var/www/wordpress
chown -R admin:admin /var/www/wordpress
ln -s /var/www/wordpress/conf_dir/wp-config.php /var/www/wordpress/wp-config.php
php-fpm7 & nginx -g "daemon off;"
