# Docker Wordpress container based on Ubuntu 16.04 LTS

Wordpress is an web content management server (https://wordpress.org).

## How to use the container image

	docker pull ffrouin/wordpress-16.04

Latest release of wordpress will be downloaded and deployed when container will run for the first time. Consult container logs to see first run tasks details. You might find usefull log files from first run in /root.

	docker run -d --name "wordpress-16.04" -p 8888:80 ffrouin/wordpress-16.04

## Account Notes :
freddy: used for support and maintenance (rsa key authentication)

