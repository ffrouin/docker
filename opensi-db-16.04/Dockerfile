FROM ffrouin:lamp-16.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen fr_FR.UTF-8

ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y bzip2

COPY firstrun.sh /root/firstrun.sh
RUN chmod +x /root/firstrun.sh
COPY mysql.sql /root/mysql.sql

ADD opensi /root/opensi

RUN perl -pi -e 's/^exit 0/\/root\/firstrun.sh \&\nexit 0/' /etc/rc.local

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
