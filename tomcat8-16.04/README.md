# ffrouin/tomcat8-16.04

ffrouin/tomcat8-16.04 is based on ffrouin/system-16.04

## How to use the container image

This may be a good basis for any web service based on Tomcat8 technologies :

	docker run -d --name "tomcat8-16.04" -p 8080:8080 -p 2222:22 \
									ffrouin:tomcat8-16.04 /sbin/my_init

http://<docker_host>:8080/ (Tomcat8)

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