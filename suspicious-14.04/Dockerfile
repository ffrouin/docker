FROM ffrouin:system-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get dist-upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y perl apache2 geoip-bin wget unzip --no-install-recommends

RUN mkdir /etc/service/apache2
RUN mkdir /etc/service/apache2/supervise
RUN echo "#!/bin/bash" > /etc/service/apache2/run
RUN echo "set -e" >> /etc/service/apache2/run
RUN echo "exec /usr/sbin/apache2ctl -DFOREGROUND" >> /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run

RUN cd /root && wget https://github.com/ffrouin/suspicious/raw/master/suspicious_0.3-1_all.deb
RUN dpkg -i /root/suspicious_0.3-1_all.deb
RUN ln -s /usr/share/suspicious/apache/suspicious.conf /etc/apache2/conf-enabled/suspicious.conf

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
