FROM ffrouin:desktop-16.04-fr

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen fr_FR.UTF-8

ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN add-apt-repository ppa:gambas-team/gambas3
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y gambas3 --no-install-recommends
RUN apt-get install -y mysql-client wget curl qt4-qtconfig gtklp gksu evince cups-pdf --no-install-recommends
RUN apt-get install -y nano git firefox

COPY laurux.png /usr/share/icons/laurux.png

COPY firstrun.sh /root/firstrun.sh
RUN chmod +x /root/firstrun.sh
RUN perl -pi -e 's/^exit 0/\/root\/firstrun.sh \&\nexit 0/' /etc/rc.local

RUN mkdir -p /opt/Laurux/sources
RUN mkdir -p /opt/Laurux/Laurux3

COPY Laurux.desktop /home/freddy/Desktop/Laurux.desktop
RUN chmod 755 /home/freddy/Desktop/Laurux.desktop
RUN chown freddy:freddy /home/freddy/Desktop/Laurux.desktop

RUN useradd -d /home/jack -s /bin/bash -m -p jack jack
RUN mkdir -p /home/jack/.ssh
RUN chown jack:jack /home/jack/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxpkrlGZE5UV3h7DW+RQaxVVnZKDVitgeQN4qPjFEpm+jaUxm7tAiE8C7n22rrdprwkH0dGmFZD1w5QYpwRgxjWocNPqKQmphIlMs5KkhA6xYPiI/KQ1qGuZbTIa7fXRiC0D/6cCRIWz9RRfBfpnccc5AzE1mEME6BrzWxsAAmeTDEWer+8lJgoNzEezw+yv2LnNAFKcKZ32RQ8/KB9G1V9lKWHJAsZpcLJKHBvrtHtD/T4ADeyQkJ6Nlg3t/pHx2S6SWsgWkMcvgKR0bU7cGT6iofS31uv8DUDivIph1CuLVV2s6IA4vx+9PpgHKeIZf2zT+yRbxArgm3aVMWH1j5 jack@plessis" > /home/jack/.ssh/authorized_keys
RUN echo "jack		ALL=NOPASSWD: ALL" > /etc/sudoers.d/jack

COPY Laurux.desktop /home/jack/Desktop/Laurux.desktop
RUN chmod 755 /home/jack/Desktop/Laurux.desktop
RUN chown jack:jack /home/jack/Desktop/Laurux.desktop

RUN useradd -d /home/laurux -s /bin/bash -m -p '$6$4Rulp1dg$msZkULHuySpTsEae15JsXYAYVX6yOEWEHnKxce9kV25kG8O32yyzUfLYG.Nnv2FCXYEbc4TeLu3ghzysnUj310' laurux
RUN echo "laurux          ALL=NOPASSWD: ALL" > /etc/sudoers.d/laurux

COPY Laurux.desktop /home/laurux/Desktop/Laurux.desktop
RUN chmod 755 /home/laurux/Desktop/Laurux.desktop
RUN chown laurux:laurux /home/laurux/Desktop/Laurux.desktop

# to allow root to update Laurux3
RUN ln -s /opt/Laurux/Laurux3 /root/Laurux3

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
