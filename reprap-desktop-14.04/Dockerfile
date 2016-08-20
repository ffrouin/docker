FROM ffrouin:desktop-14.04

MAINTAINER <freddy@linuxtribe.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TERM vt100
#ENV PULSE_SERVER=tcp:192.168.1.2

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y freeglut3 mesa-utils libgl1-mesa-dri
RUN apt-get install -y arduino openscad freecad --no-install-recommends

# arduino app requirement
RUN adduser freddy dialout

RUN apt-get install -y git build-essential libgtk2.0-dev libwxgtk2.8-dev libwx-perl libmodule-build-perl libnet-dbus-perl libexpat1-dev cpanminus liblocal-lib-perl
RUN apt-get install -y libxmu-dev freeglut3-dev libwxgtk-media2.8-dev
RUN apt-get install -y libboost-thread-dev libboost-system-dev libboost-filesystem-dev

RUN cd /opt && git clone git://github.com/alexrj/Slic3r
RUN cd /opt/Slic3r && perl Build.PL

# This needs to be run when X11 is running for opengl and wx widget testing :
# cd /opt/Slic3r && perl Build.PL --gui

# Printrun
RUN apt-get install -y python-serial python-wxgtk2.8 python-pyglet python-tornado python-setuptools python-libxml2 python-gobject avahi-daemon libavahi-compat-libdnssd1 python-dbus python-psutil
RUN apt-get install -y python-dev python-pip python-serial python-wxgtk2.8 python-pyglet python-tornado python-setuptools python-libxml2 python-gobject avahi-daemon libavahi-compat-libdnssd1 python-dbus python-psutil python-dulwich
RUN apt-get install -y python-tk ncurses-dev
RUN pip install readline
RUN pip install numpy
RUN pip install cython

RUN cd /opt && git clone https://github.com/kliment/Printrun.git
RUN cd /opt/Printrun && python setup.py build_ext --inplace

# Dulwich
#RUN cd /opt && wget https://www.dulwich.io/releases/dulwich-0.14.1.tar.gz
#RUN cd /opt && tar xzvf dulwich-0.14.1.tar.gz
#RUN cd /opt/dulwich-0.14.1 && python setup.py --pure install

# X2SW Sources
#RUN cd /opt && git clone --recurse https://github.com/dob71/x2swn.git

COPY *.desktop /home/freddy/Desktop/
COPY Readme.txt /home/freddy/Desktop/Readme.txt
RUN chown freddy:freddy /home/freddy/Desktop/Readme.txt
RUN chmod +x /home/freddy/Desktop/*.desktop
RUN chown freddy:freddy /home/freddy/Desktop/*.desktop

# cleaning

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
