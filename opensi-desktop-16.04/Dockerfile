FROM ffrouin:desktop-16.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install evince chromium-browser -y

ADD xulrunner-14.0.1.en-US.linux-x86_64.tar.bz2 /opt
ADD opensi-xuldata.tar.bz2 /opt

COPY OpenSI.desktop /home/freddy/Desktop/
RUN chmod +x /home/freddy/Desktop/OpenSI.desktop

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
