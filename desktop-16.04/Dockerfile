FROM ffrouin:system-16.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100
#ENV PULSE_SERVER=tcp:192.168.249.200

RUN locale-gen en_US.UTF-8

CMD ["/sbin/my_init"]

RUN apt-add-repository ppa:x2go/stable
RUN add-apt-repository ppa:ravefinity-project/ppa

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y xauth x11-xserver-utils --no-install-recommends
RUN apt-get install -y sshfs x2goserver x2goserver-xsession --no-install-recommends
RUN apt-get install -y gnome-icon-theme-full tango-icon-theme --no-install-recommends
RUN apt-get install -y xfwm4 xfdesktop4 xfce4-taskmanager xfce4-terminal xfce4-weather-plugin xfce4-volumed xfce4-systemload-plugin xfce4-smartbookmark-plugin xfce4-settings xfce4-session xfce4-sensors-plugin xfce4-radio-plugin xfce4-panel xfce4-notes xfce4-mount-plugin xfce4-goodies xfce4-diskperf-plugin xfce4-datetime-plugin xfce4-appfinder --no-install-recommends

#RUN apt-get install -y mesa-utils --no-install-recommends
#RUN apt-get install -y tcpdump telnet --no-install-recommends

RUN apt-get install -y vivacious-colors vivacious-folder-colors-addon
RUN apt-get install -y pavucontrol paprefs paman --no-install-recommends

# dbus setup
RUN mkdir /var/run/dbus

RUN mkdir -p /etc/service/dbus
RUN echo "#!/bin/bash" > /etc/service/dbus/run
#RUN echo "rm /var/run/dbus/pid" >> /etc/service/dbus/run
RUN echo "exec /usr/bin/dbus-daemon --system --nofork" >> /etc/service/dbus/run
RUN chmod +x /etc/service/dbus/run

# pulseaudio service configuration

RUN echo "export PULSE_SERVER=tcp:192.168.249.200" >> /etc/profile

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
