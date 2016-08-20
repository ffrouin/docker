# ffrouin/wordpress-16.04

ffrouin/wordpress-16.04 is based on ffrouin/lamp-16.04

## How to use the container image

Latest release of wordpress will be downloaded and deployed when container will run for the first time. Consult container logs to see first run tasks details. You might find usefull log files from first run in /root.

	docker run -d --name "wordpress-16.04" -p 8888:80 ffrouin/wordpress-16.04

You can access wordpress using http://<docker_host>:8888

## Accounts Notes

freddy : container support and maintenance (rsa key authentication)

--

Sources : https://github.com/ffrouin/docker
Support : Freddy Frouin http://freddy.linuxtribe.fr
