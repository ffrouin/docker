# ffrouin/wordpress-14.04

ffrouin/wordpress-14.04 is based on ffrouin/lamp-14.04

Latest release of wordpress will be downloaded and deployed when container will run for the first time. Consult container logs to see first run tasks details. You might find usefull log files from first run in /root.

## How to use the container image

	docker run -d --name "wordpress-14.04" -p 8888:80 ffrouin/wordpress-14.04

you can access your wordpress server using http://<docker_host>:8888

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr

