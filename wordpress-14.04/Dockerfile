FROM ffrouin:lamp-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN perl -pi -e 's/^exit 0/\/root\/firstrun.sh \&\nexit 0/' /etc/rc.local

COPY firstrun.sh /root/firstrun.sh
RUN chmod +x /root/firstrun.sh
COPY mysql.sql /root/mysql.sql
COPY pma-ubuntu.sh /root/pma-ubuntu.sh
RUN chmod +x /root/pma-ubuntu.sh
COPY create_tables.sql /root/create_tables.sql

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
