# ffrouin/lamp-16.04

ffrouin/lamp-16.04 is based on ffrouin/system-16.04

## How to use the container image

	docker run -d --name "lamp-16.04" -p 8888:80 \
					-p 2222:22 ffrouin:lamp-16.04 /sbin/my_init

http://<docker_host>:8888/ (Apache+Php)
http://<docker_host>:8888/phpmyadmin/ ((PhpMyAdmin - login: root / passwd: admin)

## Create your user account

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

	docker exec -ti "lamp-16.04" bash
	useradd -d /home/<your_login> -s /bin/bash -m <your_login>
	passwd <your_login>
	echo "<your_login>    ALL=NOPASSWD: ALL" > /etc/sudoers.d/<your_login>

then you might be able to run something like :

	ssh -p 2222 <your_login>@<docker_host>

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
