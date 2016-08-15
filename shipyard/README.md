# Docker on Ubuntu 14.04 LTS systems

## Shipyard Managment Script
[Shipyard](https://shipyard-project.com/) is a great initiative in order to allow end-users to access
their docker infrastructure through a Web User Interface. This tool
intend to help end-users to deploy and manage their docker/shipyard
infrastructure.

### Features
* deploy/remove controllers and agents
* build certs packages on controllers to simplify TLS deployment
* start/stop/status of controllers and agents

### Architecture
/opt/docker (application root dir : users from docker group will
be allowed to write in this directory)

/opt/docker/shipyard (copy of the deploy script from shipyard-project.com
site plus a swarm-manager port publication)

/opt/docker/certs (cert files used by containers to run TLS requests)

Then, you may deploy the shipyard-managment script wherever you like :

/etc/init.d or maybe /opt/docker.

In order shipyard to start automatically on system boot you should call
shipyard-managment script from /etc/rc.local.

## How to deploy it

### Docker on Ubuntu 14.04 LTS

First you need Docker, If you don't have it installed on your system
you may try this:

	wget -qO- https://get.docker.com/ | sh

Previous script will launch key repository import, will make architecture checks (docker is not supported on 32bits arch), and will deploy required packages in order the docker service to run. A docker group has been added on the system during installation. You may add to this group any user claiming to manipulate docker objects on this system. This group has root privileges through the docker framework, it implies you to be concerned about security threats against this system group and its members.

#### Overlay network driver

If you intend to use the overlay network driver, you'll need a TLS ready docker
framework on each of your nodes. Overlay driver allow to declare docker
network across different docker nodes.

To allow this, you'll need your different docker nodes to exchange data
through the network. As network access to the docker framework is equivalent
to a system root access, you'll absolutely need to secure this by using
TLS/SSL tcp sessions and certificate authentication.

It implies you to use a system cluster service as etcd on your differents
docker nodes. The etcd can't be dockerized as it is required by the docker
framework on your mothers hosts.

Overlay network driver requires linux kernel 3.16. You'll need to change
your ubuntu 14.04 LTS kernel source as well.

### Shipyard Managment

Then, you may be ready for this :

	git clone https://github.com/ffrouin/docker
	cd docker/shipyard
	sudo make install
	./shipyard-managment

## How does it work

### Simple usage

	Usage:  ./shipyard-managment controller <deploy|status|stop|start>
		./shipyard-managment agent deploy <controller-ip>
		./shipyard-managment agent <status|start|stop>
		./shipyard-managment remove

### SSL usage

Deploy with SSL feature enabled :

	./shipyard-managment controller deploy-ssl <controller-hostname> <controller-ip>
	./shipyard-managment agent deploy-ssl <agent-hostname> <agent-ip> <controller-ip>

Before to launch Agent SSL deployment, copy agent cert files
from the controller host in :

	/opt/docker/admin/<controller-hostname>-shipyard-agent-certs.tar.bz2

and uncompress it to /opt/docker/certs on docker agent host.
You'll find as well an archive to help certs deployment to your
admin console. You'll find it on shipyard controller in :

	/opt/docker/admin/<controller-hostname>-shipyard-cluster-certs.tar.bz2

### Docker Cluster control

To take cluster control from your console :

	export DOCKER_HOST=tcp://<swarm-manager-ip>:3376
	export DOCKER_TLS_VERIFY=1
	mkdir -p ~/.docker
	cd ~/.docker && tar xjvf /path/to/<controller-hostname>-shipyard-cluster-certs.tar.bz2

just try a :

	docker info

it should now report data from your shipyard cluster.


## How to remove it

	sudo make clean
