# ffrouin/reprap-desktop-14.04

ffrouin/reprap-desktop-14.04 is based on ffrouin/desktop-14.04 and provides following applications :
   - Arduino v1.0.5 : https://www.arduino.cc/
   - Openscad v2014.01.29 : http://www.openscad.org/
   - Freecad v0.14 : http://www.freecadweb.org/
   - Printun v2015.03.10 : http://reprap.org/wiki/Printrun
   - Slic3r v1.3.0-dev : http://slic3r.org/

## How to use the container image

	docker run --name "reprap-desktop-14.04" --device=/dev/snd:/dev/snd \
									--device=/dev/mixer:/dev/mixer \
									--device=/dev/snd/seq:/dev/snd/seq \
									--device=/dev/ttyACM0:/dev/ttyACM0 \
									--privileged -d -p 2222:22 \
									ffrouin/reprap-desktop-14.04 /sbin/my_init

## Create your user account

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

	docker exec -ti <your_container_name> bash
	useradd -d /home/<your_login> -s /bin/bash -m <your_login>
	passwd <your_login>
	cp -rf /home/freddy/Desktop /home/<your_login>/Desktop
	chown -R <your_login>:<your_login> /home/<your_login>/Desktop
	useradd <your_login> dialout

then you might be able to run something like :

	ssh -p 2222 <your_login>@<docker_host>

## Access your Reprap desktop using X2Go

Then, use X2Go (http://wiki.x2go.org/) to start a desktop session inside the container of your docker host :

	host : localhost
	login : <your_login>
	ssh port : 2222
	session type : XFCE


In order to be able to use Slic3r application, you'll need to compile gui
while your X11 session is running. Some tests during compiling needs opengl
and wx widget to be created.

Here is what you need to do, launch a terminal and run the following commands :

	sudo su
	cd /opt/Slic3r
	perl Build.PL --gui


## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr

