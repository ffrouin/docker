FROM ffrouin:system-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN perl -pi -e 's/archive/en\.archive/g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y tomcat7 ant unzip bzip2 default-jre default-jdk --no-install-recommends

RUN mkdir /etc/service/tomcat7
RUN mkdir /etc/service/tomcat7/supervise
RUN echo "#!/bin/bash" > /etc/service/tomcat7/run
RUN echo "source /etc/default/tomcat7" >> /etc/service/tomcat7/run
RUN echo "su - tomcat7 -c '/usr/lib/jvm/java-1.7.0-openjdk-amd64/bin/java -Duser.timezone=\"Europe/Paris\" -Djava.util.logging.config.file=/var/lib/tomcat7/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC -Djava.endorsed.dirs=/usr/share/tomcat7/endorsed -classpath /usr/share/tomcat7/bin/bootstrap.jar:/usr/share/tomcat7/bin/tomcat-juli.jar -Dcatalina.base=/var/lib/tomcat7 -Dcatalina.home=/usr/share/tomcat7 -Djava.io.tmpdir=/tmp/tomcat7-tomcat7-tmp org.apache.catalina.startup.Bootstrap start'" >> /etc/service/tomcat7/run
RUN chmod +x /etc/service/tomcat7/run

RUN perl -pi -e 's/^tomcat7(.+):\/bin\/false/tomcat7$1:\/bin\/bash/' /etc/passwd

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /tmp/tomcat7-tomcat7-tmp
RUN chown tomcat7:tomcat7 /tmp/tomcat7-tomcat7-tmp
