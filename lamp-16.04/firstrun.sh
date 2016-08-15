#!/bin/bash

FILE="/root/firstrun.done"

if [ -f $FILE ];
then
   exit 0
else
   sleep 2
   echo "First run detected"
   echo "Initializing phpmyadmin passwords (login: admin / passwd: admin)"
   /usr/bin/mysqladmin password admin >/root/mysqladmin.log 2>&1
   echo "Initializing mysql passwords (login: root / passwd: admin)"
   /bin/cat /root/mysql.sql | mysql -u root -h localhost -padmin >/root/mysql.log 2>&1
   echo "Initializing phpmyadmin data within mysql"
   mysql -u root -h localhost -padmin < /usr/share/phpmyadmin/sql/create_tables.sql >/root/phpmyadmin.log 2>&1
   echo "Firstrun tasks done"
   /bin/touch /root/firstrun.done
fi

exit 0
