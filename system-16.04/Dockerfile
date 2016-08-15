FROM phusion/baseimage:0.9.19

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

# system update
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y telnet sudo

# ssh service modificaiton

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN sed 's/#RSAAuthentication yes/RSAAuthentication yes/' /etc/ssh/sshd_config
RUN sed 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
RUN sed 's/#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# end user account setup

RUN useradd -d /home/freddy -s /bin/bash -m -p freddy freddy
RUN mkdir -p /home/freddy/.ssh
RUN chown freddy:freddy /home/freddy/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJlB/DOUrLmk5kdVx6TC6/BJ1mggCBX8d1rKAMioSUtU2ihDAc0tFnLtO02C9t7LNiqRoUKjThXMkXn7AWQtFQcQ0dwDj9e6LfPWROTKaBatPPSCOGzZ1HqFb4v56lEM0QDqXLiR/9xu1FUB43hNIOyZ+Mr0zyRTfPXGr8iEiiDYSJFAvd7qaNMJJnajCLQWVUTv1dY3nYRtntHswI2PBxvalXcwjB9JUS+e0M6Yg6kDbJcdrpiUm7vNPBP29EmPfU854In8iZT8/gc+Z8qfociZoSawaayG8NoHxji28YEUew7c4yCg5lHK4sJo3re0+uIwDYdNrbkiqcRTfo5LnD freddy@helix" > /home/freddy/.ssh/authorized_keys

# root access setup

RUN mkdir -p /root/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJlB/DOUrLmk5kdVx6TC6/BJ1mggCBX8d1rKAMioSUtU2ihDAc0tFnLtO02C9t7LNiqRoUKjThXMkXn7AWQtFQcQ0dwDj9e6LfPWROTKaBatPPSCOGzZ1HqFb4v56lEM0QDqXLiR/9xu1FUB43hNIOyZ+Mr0zyRTfPXGr8iEiiDYSJFAvd7qaNMJJnajCLQWVUTv1dY3nYRtntHswI2PBxvalXcwjB9JUS+e0M6Yg6kDbJcdrpiUm7vNPBP29EmPfU854In8iZT8/gc+Z8qfociZoSawaayG8NoHxji28YEUew7c4yCg5lHK4sJo3re0+uIwDYdNrbkiqcRTfo5LnD freddy@helix" > /root/.ssh/authorized_keys

# visudo

RUN echo "freddy	ALL=NOPASSWD: ALL" > /etc/sudoers.d/freddy
# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
