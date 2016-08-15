#!/bin/bash

FILE="/root/firstrun.done"

if [ -f $FILE ];
then
   exit 0
else
   sleep 2
   echo "Initializing phpmyadmin passwords (login: admin / passwd: admin)"
   /usr/bin/mysqladmin password admin >/root/mysqladmin.log 2>&1
   echo "Creating wordpress user into database (login : wordpress / password : wordpress)"
   mysql -u root -h localhost -padmin </root/mysql.sql >/root/mysql.log 2>&1
   echo "Fixing PMA issue"
   /root/pma-ubuntu.sh >/root/pma-ubuntu.log 2>&1
   echo "Firstrun tasks done"
   echo "Downloading latest release of Wordpress"
   cd /var/www && wget https://wordpress.org/latest.tar.gz >/root/wordpress_download.log 2>&1
   echo "Uncompressing Wordpress"
   cd /var/www && rm -rf html
   cd /var/www && tar xzvf latest.tar.gz && mv wordpress html
   echo "Fixing config"
   cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
   perl -pi -e 's/username_here/wordpress/' /var/www/html/wp-config.php
   perl -pi -e 's/password_here/wordpress/' /var/www/html/wp-config.php
   perl -pi -e 's/database_name_here/wordpress/' /var/www/html/wp-config.php
   /bin/touch /root/firstrun.done
   echo "Firstrun tasks done"
fi

exit 0
