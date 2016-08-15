FROM ffrouin:system-16.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

RUN locale-gen en_US.UTF-8

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y wget mysql-server phpmyadmin apache2-utils

RUN mkdir /etc/service/apache2
RUN mkdir /etc/service/apache2/supervise
RUN echo "#!/bin/bash" > /etc/service/apache2/run
RUN echo "set -e" >> /etc/service/apache2/run
RUN echo "exec /usr/sbin/apache2ctl -DFOREGROUND" >> /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run

RUN cd /etc/apache2/conf-enabled && ln -s /etc/phpmyadmin/apache.conf phpmyadmin.conf

RUN mkdir /etc/service/mysql 
RUN mkdir /etc/service/mysql/supervise
RUN echo "#!/bin/bash" > /etc/service/mysql/run
RUN echo "set -e" >> /etc/service/mysql/run
RUN echo "exec /usr/sbin/mysqld" >> /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run

RUN perl -pi -e 's/^exit 0/\/root\/firstrun.sh \&/' /etc/rc.local

COPY firstrun.sh /root/firstrun.sh
RUN chmod +x /root/firstrun.sh
COPY mysql.sql /root/mysql.sql

RUN htpasswd -b /etc/phpmyadmin/htpasswd.setup admin admin
RUN perl -pi -e "s/^\\\$dbpass=\'.+\'/\\\$dbpass=\'admin\'/" /etc/phpmyadmin/config-db.php
RUN perl -pi -e "s/^\\\$dbuser=\'.+\'/\\\$dbuser=\'root\'/" /etc/phpmyadmin/config-db.php

RUN perl -pi -e "s/^bind-address[\s\t]+= 127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
RUN mkdir /var/run/mysqld
RUN chown mysql:mysql /var/run/mysqld


# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
