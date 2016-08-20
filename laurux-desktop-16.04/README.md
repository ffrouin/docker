# ffrouin/laurux-desktop-16.04

ffrouin/laurux-desktop-16.04 is based on ffrouin/desktop-16.04-fr

## How to use the container image

We supposed you ran a ffrouin/laurux-db-16.04 image named "laurux-db-customer1" :

	docker run --name "laurux-customer1" \
						--link laurux-db-customer1:laurux-db-customer1 \
						-d -p 2222:22 ffrouin/laurux-desktop-16.04 /sbin/my_init

## Access your laurux desktop using X2Go

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

## Accounts Notes
freddy : container support and maintenance (rsa key authentication)
jack : laurux dev support and maintenance (rsa key authentication)
laurux : your account as user (password is laurux)

http://www.laurux.fr
http://laurux.linuxtribe.fr

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
