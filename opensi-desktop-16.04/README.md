# ffrouin/opensi-desktop-16.04

ffrouin/opensi-desktop-16.04 is based on ffrouin/desktop-16.04

## How to use the container image

	docker run --name "opensi-desktop-16.04" \
			--link opensi-server-16.04:opensi-server-16.06 \
			ffrouin:opensi-desktop-16.04 /sbin/my_init

## Create your user account

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

	docker exec -ti <your_container_name> bash
	useradd -d /home/<your_login> -s /bin/bash -m <your_login>
	passwd <your_login>
	echo "<your_login>	ALL=NOPASSWD: ALL" > /etc/sudoers.d/<your_login>

then you might be able to run something like :

	ssh -p 2222 <your_login>@<docker_host>

## Access your docker opensi-desktop using X2Go

Then, use X2Go (http://wiki.x2go.org/) to start a opensi-desktop session inside the container of your docker host :

	host : localhost
	login : <your_login>
	ssh port : 2222
	session type : XFCE

## Launch OpenSI Client

You may find a Desktop launcher in /home/freddy/Desktop :

	cp /home/freddy/Desktop/*.desktop $HOME/Desktop/

Or open a terminal an use this command :

	/opt/xulrunner/xulrunner-bin /opt/opensi/application.ini

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
