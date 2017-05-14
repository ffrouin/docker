FROM ffrouin:tomcat7-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y openjdk-7-jre openjdk-7-jdk

RUN perl -pi -e 's/#TOMCAT7_SECURITY=no/TOMCAT7_SECURITY=no/' /etc/default/tomcat7
RUN perl -pi -e 's/#JAVA_HOME=\/usr\/lib\/jvm\/java-7-openjdk/JAVA_HOME=\/usr\/lib\/jvm\/java-9-openjdk-amd64/' /etc/default/tomcat7

RUN perl -pi -e 's/<Context>/<Context allowLinking=\"true\">/' /var/lib/tomcat7/conf/context.xml

ADD opensi-serveur-4.8.0-1-EC.tgz /var/lib/tomcat7/webapps/
RUN find /var/lib/tomcat7/webapps/OpenSI -type f | sed -e 's/^/"/' | sed -e 's/$/"/' | xargs chmod 644
RUN find /var/lib/tomcat7/webapps/OpenSI -type d | sed -e 's/^/"/' | sed -e 's/$/"/' | xargs chmod 755
RUN cd /var/lib/tomcat7/webapps/OpenSI
RUN chmod +x /var/lib/tomcat7/webapps/OpenSI/deploy
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/configuration
RUN cd /var/lib/tomcat7/webapps/OpenSI/ && cp opensi.cfg.template /var/lib/tomcat7/webapps/opensi-parametres/configuration/opensi.cfg

#RUN perl -pi -e 's/rechDossier select distinct d\.Dossier_Id, d\.Nom from DOSSIER d/rechDossier select d\.Dossier_Id\, d\.Nom from DOSSIER d/' /var/lib/tomcat7/webapps/OpenSI/ESRootDir/ESTemplates/Shop/Compta/GetRDF/RechercheDossier.tmpl
#RUN perl -pi -e 's/getJournaux select distinct j\.Code_Journal/getJournaux select j\.Code_Journal/' /var/lib/tomcat7/webapps/OpenSI/ESRootDir/ESTemplates/Shop/Compta/GetRDF/combo-journaux.tmpl

RUN perl -pi -e 's/tomcat5/tomcat7/g' /var/lib/tomcat7/webapps/opensi-parametres/configuration/opensi.cfg
RUN perl -pi -e 's/localhost/opensi-db-14.04/g' /var/lib/tomcat7/webapps/opensi-parametres/configuration/opensi.cfg
RUN perl -pi -e 's/#trace.file: opensi.log/trace.file: opensi.log/' /var/lib/tomcat7/webapps/opensi-parametres/configuration/opensi.cfg
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/datas
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/graph
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/iobuffer
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/logos
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/pdf
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/photos_articles
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/photos_familles
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/photos_marques
RUN mkdir -p /var/lib/tomcat7/webapps/opensi-parametres/rapports
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/datas /var/lib/tomcat7/webapps/OpenSI/datas
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/graph /var/lib/tomcat7/webapps/OpenSI/graph
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/iobuffer /var/lib/tomcat7/webapps/OpenSI/iobuffer
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/logos /var/lib/tomcat7/webapps/OpenSI/logos
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/pdf /var/lib/tomcat7/webapps/OpenSI/pdf
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/photos_articles /var/lib/tomcat7/webapps/OpenSI/photos_articles
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/photos_familles /var/lib/tomcat7/webapps/OpenSI/photos_familles
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/photos_marques /var/lib/tomcat7/webapps/OpenSI/photos_marques
RUN ln -s /var/lib/tomcat7/webapps/opensi-parametres/rapports /var/lib/tomcat7/webapps/OpenSI/rapports

RUN export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 && cd /var/lib/tomcat7/webapps/OpenSI/WEB-INF && ant
RUN chown -R tomcat7:tomcat7 /var/lib/tomcat7/webapps

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /tmp/tomcat7-tomcat7-tmp
RUN chown tomcat7:tomcat7 /tmp/tomcat7-tomcat7-tmp

