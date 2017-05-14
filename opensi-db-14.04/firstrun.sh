#!/bin/bash

FILE="/root/firstrun.done"

if [ -f $FILE ];
then
   exit 0
else
   sleep 5
   echo "First run detected"
   echo "Initializing phpmyadmin passwords (login: admin / passwd: admin)"
   /usr/bin/mysqladmin password admin >/root/mysqladmin.log 2>&1
   echo "Initializing mysql passwords (login: root / passwd: admin)"
   /bin/cat /root/mysql.sql | mysql -u root -h localhost -padmin >/root/mysql.log 2>&1
   echo "Fixing PMA issue"
   /root/pma-ubuntu.sh >/root/pma-ubuntu.log 2>&1
   echo "Firstrun tasks done"
   /bin/touch /root/firstrun.done
   echo "OpenSI database init"
   cd /root/opensi/ && /bin/cat SchemaGeneral.sql | mysql -u opensi -h localhost -popensi >/root/opensi.log 2>&1
fi

exit 0
