#!bin/sh

# https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
tar -xf /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz -C /tmp/
mv -f /tmp/phpMyAdmin-5.0.4-all-languages /var/www/phpmyadmin
mv -f /tmp/config.inc.php /var/www/phpmyadmin/

mv /tmp/localhost.conf /etc/nginx/conf.d/
rm /etc/nginx/conf.d/default.conf

if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi

php-fpm7 & nginx -g "daemon off;"
