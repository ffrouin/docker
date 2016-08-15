FROM ubuntu:14.04
MAINTAINER Phusion <info@phusion.nl>

ADD . /bd_build

RUN /bd_build/prepare.sh
RUN /bd_build/system_services.sh
RUN /bd_build/utilities.sh
RUN /bd_build/fix_pam_bug.sh
RUN /bd_build/cleanup.sh

CMD ["/sbin/my_init"]
