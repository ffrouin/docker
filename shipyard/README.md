# docker
Shipyard

## Shipyard Management Script
Shipyard is a great initiative in order to allow end-users to access
their docker infrastructure though a Web User Interface. This tool
intend to help end-users to deploy and manage their docker/shipyard
infrastructure.

### Features
* deploy/remove controllers and agents
* build certs packages on controllers to simplify TLS deployment
* start/stop/status of controllers and agents

### Architecture
/opt/docker (application root dir : users from docker groups will
be allowed to write in this directory)

/opt/docker/shipyard (copy of the deploy script from shipyard-project.org
site plus a swarm-agent port publication)

/opt/docker/certs (cert files used by containers to run TLS requests)

Then, you may deploy the shipyard-management script wherever you like :

/etc/init.d or maybe /opt/docker.

## How to deploy it

	git clone https://github.com/ffrouin/docker
	cd docker/shipyard
	sudo make install
	./shipyard-management

## How does it work

### Simple usage

Usage: ./shipyard-management controller <deploy|status|stop|start>

       ./shipyard-management agent deploy <controller-ip>

       ./shipyard-management agent <status|start|stop>

       ./shipyard-management remove

### SSL usage

Deploy with SSL feature enabled :

./shipyard-management controller deploy-ssl <controller-hostname> <controller-ip>

./shipyard-management agent deploy-ssl <agent-hostname> <agent-ip> <controller-ip>

Before to launch Agent SSL deployment, copy agent cert files

from the controller host in :

/opt/docker/admin/<controller-hostname>-shipyard-agent-certs.tar.bz2

and uncompress it to /opt/docker/certs on docker agent host.

You'll find as well an archive to help certs deployment to your

admin console. You'll find it on shipyard controller in :

/opt/docker/admin/<controller-hostname>-shipyard-cluster-certs.tar.bz2

### Cluster control

To take cluster control from your console :

	export DOCKER_HOST=tcp://<swarm-node-ip>:3376
	export DOCKER_TLS_VERIFY=1
	mkdir -p ~/.docker
	cd ~/.docker && tar xjvf /path/to/<controller-hostname>-shipyard-cluster-certs.tar.bz2

## How to remove it

	sudo make clean
