# ffrouin/laurux-db-14.04

ffrouin/laurux-db-14.04 is based on ffrouin/lamp-14.04.

## How to use the container image

If you need to access phpmyadmin from the docker host, you may expose the port 80 of the container to a port of your choice, 8888 as an example :

	docker run -d --name "laurux-db-customer1" -p 8888:80 \
							ffrouin/laurux-db-14.04 /sbin/my_init

To run for production (don't forget to reset passwords):

	docker run -d --name "laurux-db-customer1" ffrouin/laurux-db /sbin/my_init

Mysql passwords are set to :
   - http://<docker_host>:8888/phpmyadmin/setup (login : admin / passwd : admin)
   - http://<docker_host>:8888/phpmyadmin (login: root / passwd : admin)

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)
jack : laurux dev support and maintenance (rsa key authentication)

http://www.laurux.fr
http://laurux.linuxtribe.fr

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
