# ffrouin/desktop-14.04-fr

ffrouin/desktop-14.04-fr is based on ffrouin/desktop-14.04

# How to use the container image

	docker run --name "desktop-14.04-fr" --device=/dev/snd:/dev/snd \
								--device=/dev/mixer:/dev/mixer \
								--device=/dev/snd/seq:/dev/snd/seq \
								--privileged -d -p 2222:22 \
								ffrouin/desktop-14.04-fr /sbin/my_init

## Create your user account

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

	docker exec -ti <your_container_name> bash
	useradd -d /home/<your_login> -s /bin/bash -m <your_login>
	passwd <your_login>
	echo "<your_login>	ALL=NOPASSWD: ALL" > /etc/sudoers.d/<your_login>

then you might be able to run something like :

	ssh -p 2222 <your_login>@<docker_host>

## Access your docker desktop using X2Go

Then, use X2Go (http://wiki.x2go.org/) to start a desktop session inside the container of your docker host :

	host : localhost
	login : <your_account>
	ssh port : 2222
	session type : XFCE

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
