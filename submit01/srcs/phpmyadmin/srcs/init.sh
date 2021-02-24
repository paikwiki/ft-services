#!bin/sh

# https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
mv -f /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz /var/www/
tar -xf /var/www/phpMyAdmin-5.0.4-all-languages.tar.gz -C /var/www/
mv /var/www/phpMyAdmin-5.0.4-all-languages/* /var/www/phpmyadmin/
rm -rf /var/www/phpMyAdmin-5.0.4-all-languages*

mv /tmp/localhost.conf /etc/nginx/conf.d/
rm /etc/nginx/conf.d/default.conf

if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi

ln -s /var/www/phpmyadmin/conf_dir/config.inc.php \
		/var/www/phpmyadmin/config.inc.php
mkdir -p /var/www/phpmyadmin/tmp
chmod 777 /var/www/phpmyadmin/tmp

php-fpm7 & nginx -g "daemon off;"
