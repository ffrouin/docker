install:
	mkdir -p /opt/docker
	chgrp docker /opt/docker
	chmod 775 /opt/docker
	cp lib/shipyard /opt/docker/
	chmod 755 /opt/docker/shipyard
	echo "You can now run the shipyard-management script !"

clean:
	rm -rf /opt/docker
