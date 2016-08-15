FROM ffrouin:system-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y wget mysql-server php5-mcrypt phpmyadmin apache2-utils --no-install-recommends

RUN mkdir /etc/service/apache2
RUN mkdir /etc/service/apache2/supervise
RUN echo "#!/bin/bash" > /etc/service/apache2/run
RUN echo "set -e" >> /etc/service/apache2/run
RUN echo "exec /usr/sbin/apache2ctl -DFOREGROUND" >> /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run

RUN cd /etc/apache2/conf-enabled && ln -s /etc/phpmyadmin/apache.conf phpmyadmin.conf
RUN /usr/sbin/php5enmod mcrypt

RUN mkdir /etc/service/mysql 
RUN mkdir /etc/service/mysql/supervise
RUN echo "#!/bin/bash" > /etc/service/mysql/run
RUN echo "set -e" >> /etc/service/mysql/run
RUN echo "exec /usr/sbin/mysqld" >> /etc/service/mysql/run
RUN echo "exec /usr/bin/mysqladmin password admin" >> /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run

RUN perl -pi -e 's/^exit 0/\/root\/firstrun.sh \&/' /etc/rc.local

COPY firstrun.sh /root/firstrun.sh
RUN chmod +x /root/firstrun.sh
COPY create_tables.sql /root/create_tables.sql
COPY mysql.sql /root/mysql.sql
COPY pma-ubuntu.sh /root/pma-ubuntu.sh
RUN chmod +x /root/pma-ubuntu.sh

RUN htpasswd -b /etc/phpmyadmin/htpasswd.setup admin admin
RUN perl -pi -e "s/^\\\$dbpass=\'.+\'/\\\$dbpass=\'admin\'/" /etc/phpmyadmin/config-db.php
RUN perl -pi -e "s/^\\\$dbuser=\'.+\'/\\\$dbuser=\'root\'/" /etc/phpmyadmin/config-db.php

RUN perl -pi -e "s/^bind-address[\s\t]+= 127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
