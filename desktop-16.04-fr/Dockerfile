FROM ffrouin:desktop-16.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen fr_FR.UTF-8

ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

ENV TERM vt100
#ENV PULSE_SERVER=tcp:192.168.249.200


CMD ["/sbin/my_init"]

RUN perl -pi -e 's/en_US/fr_FR/' /etc/default/locale

RUN echo "export LANG=fr_FR.UTF-8" >> /etc/profile
RUN echo "export LC_ALL=fr_FR.UTF-8" >> /etc/profile

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y language-pack-fr language-pack-fr-base manpages-fr
RUN apt-get install -y language-selector-gnome language-selector-common --no-install-recommends

# pulseaudio service configuration

#RUN echo "export PULSE_SERVER=tcp:192.168.249.200" >> /etc/profile

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
