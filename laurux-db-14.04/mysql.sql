CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;
CREATE USER 'root'@'172.%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.%' WITH GRANT OPTION;
CREATE USER 'laurux'@'172.%' IDENTIFIED BY 'laurux';
GRANT ALL PRIVILEGES ON *.* TO 'laurux'@'172.%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
