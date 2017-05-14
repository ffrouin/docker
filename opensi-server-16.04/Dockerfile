FROM ffrouin:tomcat8-16.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN perl -pi -e 's/#TOMCAT8_SECURITY=no/TOMCAT8_SECURITY=no/' /etc/default/tomcat8
RUN perl -pi -e 's/#JAVA_HOME=\/usr\/lib\/jvm\/java-7-openjdk/JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-amd64/' /etc/default/tomcat8

RUN perl -pi -e 's/<Context>/<Context>\n\t<Resources allowLinking=\"true\" \/>/' /var/lib/tomcat8/conf/context.xml

ADD opensi-serveur-4.8.0-1-EC.tgz /var/lib/tomcat8/webapps/
RUN find /var/lib/tomcat8/webapps/OpenSI -type f | sed -e 's/^/"/' | sed -e 's/$/"/' | xargs chmod 644
RUN find /var/lib/tomcat8/webapps/OpenSI -type d | sed -e 's/^/"/' | sed -e 's/$/"/' | xargs chmod 755
RUN cd /var/lib/tomcat8/webapps/OpenSI
RUN chmod +x /var/lib/tomcat8/webapps/OpenSI/deploy
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/configuration
RUN cd /var/lib/tomcat8/webapps/OpenSI/ && cp opensi.cfg.template /var/lib/tomcat8/webapps/opensi-parametres/configuration/opensi.cfg

RUN perl -pi -e 's/rechDossier select distinct d\.Dossier_Id, d\.Nom from DOSSIER d/rechDossier select d\.Dossier_Id\, d\.Nom from DOSSIER d/' /var/lib/tomcat8/webapps/OpenSI/ESRootDir/ESTemplates/Shop/Compta/GetRDF/RechercheDossier.tmpl
RUN perl -pi -e 's/getJournaux select distinct j\.Code_Journal/getJournaux select j\.Code_Journal/' /var/lib/tomcat8/webapps/OpenSI/ESRootDir/ESTemplates/Shop/Compta/GetRDF/combo-journaux.tmpl

RUN perl -pi -e 's/tomcat5/tomcat8/g' /var/lib/tomcat8/webapps/opensi-parametres/configuration/opensi.cfg
RUN perl -pi -e 's/localhost/opensi-db-16.04/g' /var/lib/tomcat8/webapps/opensi-parametres/configuration/opensi.cfg
RUN perl -pi -e 's/#trace.file: opensi.log/trace.file: opensi.log/' /var/lib/tomcat8/webapps/opensi-parametres/configuration/opensi.cfg
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/datas
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/graph
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/iobuffer
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/logos
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/pdf
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/photos_articles
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/photos_familles
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/photos_marques
RUN mkdir -p /var/lib/tomcat8/webapps/opensi-parametres/rapports
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/datas /var/lib/tomcat8/webapps/OpenSI/datas
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/graph /var/lib/tomcat8/webapps/OpenSI/graph
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/iobuffer /var/lib/tomcat8/webapps/OpenSI/iobuffer
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/logos /var/lib/tomcat8/webapps/OpenSI/logos
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/pdf /var/lib/tomcat8/webapps/OpenSI/pdf
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/photos_articles /var/lib/tomcat8/webapps/OpenSI/photos_articles
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/photos_familles /var/lib/tomcat8/webapps/OpenSI/photos_familles
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/photos_marques /var/lib/tomcat8/webapps/OpenSI/photos_marques
RUN ln -s /var/lib/tomcat8/webapps/opensi-parametres/rapports /var/lib/tomcat8/webapps/OpenSI/rapports

RUN cd /var/lib/tomcat8/webapps/OpenSI/WEB-INF && ant
RUN chown -R tomcat8:tomcat8 /var/lib/tomcat8/webapps

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /tmp/tomcat8-tomcat8-tmp
RUN chown tomcat8:tomcat8 /tmp/tomcat8-tomcat8-tmp

