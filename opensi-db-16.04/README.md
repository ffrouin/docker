# ffrouin/opensi-db-16.04

ffrouin/opensi-db-16.04 is based on ffrouin/lamp-16.04.

## How to use the container image

If you need to access phpmyadmin from the docker host, you may expose the port 80 of the container to a port of your choice, 8888 as an example :

	docker run -d --name "opensi-db-customer1" -p 8888:80 \
							ffrouin/opensi-db-16.04 /sbin/my_init

To run for production (don't forget to reset passwords):

	docker run -d --name "opensi-db" ffrouin/opensi-db-16.04 /sbin/my_init

Mysql passwords are set to :
   - http://<docker_host>:8888/phpmyadmin/setup (login : admin / passwd : admin)
   - http://<docker_host>:8888/phpmyadmin (login: root / passwd : admin)
   - http://<docker_host>:8888/phpmyadmin (login: opensi / passwd : opensi)

## Create your user account

To access container with ssh from your workstation, you may first log from docker host in order to create your user account :

        docker exec -ti <your_container_name> bash
        useradd -d /home/<your_login> -s /bin/bash -m <your_login>
        passwd <your_login>
        echo "<your_login>      ALL=NOPASSWD: ALL" > /etc/sudoers.d/<your_login>

then you might be able to run something like :

        ssh -p 2222 <your_login>@<docker_host>

ssh server is configured to accept RSA key authentication. Put public keys in $HOME/.ssh/authorized_keys (1 line per key).

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
