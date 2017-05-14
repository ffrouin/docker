FROM ffrouin:system-16.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN perl -pi -e 's/archive/en\.archive/g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y tomcat8 ant unzip bzip2 default-jre default-jdk --no-install-recommends

RUN mkdir /etc/service/tomcat8
RUN mkdir /etc/service/tomcat8/supervise
RUN echo "#!/bin/bash" > /etc/service/tomcat8/run
RUN echo "source /etc/default/tomcat8" >> /etc/service/tomcat8/run
RUN echo "su - tomcat8 -c '/usr/lib/jvm/java-8-openjdk-amd64/bin/java -Duser.timezone=\"Europe/Paris\" -Djava.util.logging.config.file=/var/lib/tomcat8/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC -Djava.endorsed.dirs=/usr/share/tomcat8/endorsed -classpath /usr/share/tomcat8/bin/bootstrap.jar:/usr/share/tomcat8/bin/tomcat-juli.jar -Dcatalina.base=/var/lib/tomcat8 -Dcatalina.home=/usr/share/tomcat8 -Djava.io.tmpdir=/tmp/tomcat8-tomcat8-tmp org.apache.catalina.startup.Bootstrap start'" >> /etc/service/tomcat8/run
RUN chmod +x /etc/service/tomcat8/run

RUN perl -pi -e 's/^tomcat8(.+):\/bin\/false/tomcat8$1:\/bin\/bash/' /etc/passwd

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /tmp/tomcat8-tomcat8-tmp
RUN chown tomcat8:tomcat8 /tmp/tomcat8-tomcat8-tmp
