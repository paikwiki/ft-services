# Wait that mysql was up
until mysql
do
	echo "NO_UP"
done

mysql << EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'admin'@'%' IDENTIFIED BY 'password';
GRANT ALL ON *.* TO 'admin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
