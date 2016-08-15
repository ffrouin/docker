# Docker LAMP container based on Ubuntu 16.04 LTS

LAMP - Linux Apache Mysql Php

## How to use the container image

	docker pull ffrouin/lamp-16.04

This may be a good basis for any web service based on LAMP technologies :

	docker run -d --name "lamp-16.04" -p 8888:80 -p 2222:22 ffrouin:lamp-16.04 /sbin/my_init

	http://<docker_host>:8888/ (Apache+Php)
	http://<docker_host>:8888/phpmyadmin/ (PhpMyAdmin)

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

	docker exec -ti "lamp-16.04" bash
	useradd -d /home/<your_login> -s /bin/bash -m <your_login>
	passwd <your_login>

then you might be able to run something like :

	ssh -p 2222 <your_login>@<docker_host>

## Account Notes :
freddy: used for support and maintenance (rsa key authentication)

