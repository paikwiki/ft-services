FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@localhost IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
