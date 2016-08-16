FROM ffrouin:lamp-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen fr_FR.UTF-8

ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr

ENV TERM vt100

CMD ["/sbin/my_init"]

COPY firstrun.sh /root/firstrun.sh
RUN chmod +x /root/firstrun.sh
COPY mysql.sql /root/mysql.sql
COPY pma-ubuntu.sh /root/pma-ubuntu.sh
RUN chmod +x /root/pma-ubuntu.sh
COPY create_tables.sql /root/create_tables.sql

RUN perl -pi -e 's/^exit 0/\/root\/firstrun.sh \&\nexit 0/' /etc/rc.local

RUN useradd -d /home/jack -s /bin/bash -m -p jack jack
RUN mkdir -p /home/jack/.ssh
RUN chown jack:jack /home/jack/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxpkrlGZE5UV3h7DW+RQaxVVnZKDVitgeQN4qPjFEpm+jaUxm7tAiE8C7n22rrdprwkH0dGmFZD1w5QYpwRgxjWocNPqKQmphIlMs5KkhA6xYPiI/KQ1qGuZbTIa7fXRiC0D/6cCRIWz9RRfBfpnccc5AzE1mEME6BrzWxsAAmeTDEWer+8lJgoNzEezw+yv2LnNAFKcKZ32RQ8/KB9G1V9lKWHJAsZpcLJKHBvrtHtD/T4ADeyQkJ6Nlg3t/pHx2S6SWsgWkMcvgKR0bU7cGT6iofS31uv8DUDivIph1CuLVV2s6IA4vx+9PpgHKeIZf2zT+yRbxArgm3aVMWH1j5 jack@plessis" > /home/jack/.ssh/authorized_keys
RUN echo "jack		ALL=NOPASSWD: ALL" > /etc/sudoers.d/jack

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
