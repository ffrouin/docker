# ffrouin/system-16.04

ffrouin/system-16.04 is based on phusion/baseimage:0.9.19

Basic system services configured for you : syslog, cron, ssh

## How to use the container image

Expose container ssh port to the port of your choice, here 2222 :

	docker run -d --name "your_container_name" -p 2222:22 ffrouin/system-16.04

## Create your user account

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

	docker exec -ti <your_container_name> bash
	useradd -d /home/<your_login> -s /bin/bash -m <your_login>
	passwd <your_login>
	echo "<your_login>	ALL=NOPASSWD: ALL" > /etc/sudoers.d/<your_login>

then you might be able to run something like :

	ssh -p 2222 <your_login>@<docker_host>

ssh server is configured to accept RSA key authentication. Put public keys in $HOME/.ssh/authorized_keys (1 line per key).

## Account Notes
freddy: used for support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
