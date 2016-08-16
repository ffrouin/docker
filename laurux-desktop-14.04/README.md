# Docker laurux database container based on Ubuntu 14.04 LTS

## How to use the container image

	docker pull ffrouin/laurux-desktop-14.04

We supposed you ran a ffrouin/laurux-db-14.04 image named "laurux-db-customer1" :

	docker run --name "laurux-customer1" --link laurux-db-customer1:laurux-db-customer1 -d -p 2222:22 ffrouin/laurux-desktop /sbin/my_init

Then, use X2Go (http://wiki.x2go.org/) to start a desktop session inside the container of your docker host :

	host : localhost
	login : laurux
	ssh port : 2222
	session type : XFCE

Laurux icon is on the desktop. Last release of Laurux binaries and sources will be downloaded at the first run of the container (/opt/Laurux).

When you will start Laurux for the first time, you'll be required to fill the database form with the following data :

	user : laurux
	password : laurux
	host : laurux-db-customer1

Restart the application and you'll be ready to start using Laurux.

Accounts Notes :

freddy : container support and maintenance (rsa key authentication)
jack : laurux dev support and maintenance (rsa key authentication)
laurux : your account as user (password is laurux)

http://www.laurux.fr
http://laurux.linuxtribe.fr
