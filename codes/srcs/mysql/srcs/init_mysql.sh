# Wait that mysql was up
until mysql
do
	echo "NO_UP"
done

mysql << EOF
CREATE DATABASE wordpress;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
