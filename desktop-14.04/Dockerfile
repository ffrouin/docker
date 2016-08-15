FROM ffrouin:system-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100
#ENV PULSE_SERVER=tcp:192.168.1.2

CMD ["/sbin/my_init"]

RUN apt-add-repository ppa:x2go/stable
RUN add-apt-repository ppa:ravefinity-project/ppa
RUN add-apt-repository ppa:chromium-daily/stable

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y xauth x11-xserver-utils --no-install-recommends
RUN apt-get install -y x2goserver x2goserver-xsession --no-install-recommends
RUN apt-get install -y gnome-icon-theme-full tango-icon-theme --no-install-recommends
RUN apt-get install -y xfwm4 xfdesktop4 xfce4-taskmanager xfce4-terminal xfce4-weather-plugin xfce4-volumed xfce4-systemload-plugin xfce4-smartbookmark-plugin xfce4-settings xfce4-session xfce4-sensors-plugin xfce4-radio-plugin xfce4-panel xfce4-notes xfce4-mount-plugin xfce4-mixer xfce4-goodies xfce4-diskperf-plugin xfce4-datetime-plugin xfce4-appfinder --no-install-recommends

#RUN apt-get install -y mesa-utils --no-install-recommends
#RUN apt-get install -y tcpdump telnet --no-install-recommends

RUN apt-get install -y chromium-browser --no-install-recommends
RUN apt-get install -y vivacious-colors vivacious-folder-colors-addon
RUN apt-get install -y pavucontrol paprefs paman --no-install-recommends

# dbus setup
RUN mkdir /var/run/dbus

RUN mkdir -p /etc/service/dbus
RUN echo "#!/bin/bash" > /etc/service/dbus/run
RUN echo "exec /bin/dbus-daemon --system --nofork" >> /etc/service/dbus/run
RUN chmod +x /etc/service/dbus/run

# pulseaudio service configuration

RUN echo "export PULSE_SERVER=tcp:192.168.1.2" >> /etc/profile

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
