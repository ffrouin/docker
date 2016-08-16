# Docker X2Go/XFCE container based on Ubuntu 14.04 LTS - French

XFCE Desktop you can access with X2Go client.

## How to use the container image

	docker pull ffrouin/desktop-14.04-fr

To run the container, you can use the following :

	docker run --name "desktop-14.04-fr" --device=/dev/snd:/dev/snd --device=/dev/mixer:/dev/mixer --device=/dev/snd/seq:/dev/snd/seq --privileged -d -p 2222:22 ffrouin:desktop-14.04-fr /sbin/my_init

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

	docker exec -ti <your_container_name> bash
	useradd -d /home/<your_login> -s /bin/bash -m <your_login>
	passwd <your_login>

then you might be able to run something like :

	ssh -p 2222 <your_login>@<docker_host>

Then, use X2Go (http://wiki.x2go.org/) to start a desktop session inside the container of your docker host :

	host : localhost
	login : <your_account>
	ssh port : 2222
	session type : XFCE

## Account Notes :
freddy: used for support and maintenance (rsa key authentication)

