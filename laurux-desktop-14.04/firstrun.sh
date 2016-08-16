#!/bin/bash

FILE="/root/firstrun.done"

if [ -f $FILE ];
then
   exit 0
else
   mkdir -p /opt/Laurux/sources
   echo "Downloading Laurux sources (/opt/Laurux/sources)"
   cd /opt/Laurux/sources && git clone 'https://github.com/Laurux/Laurux' >/root/laurux_sources.log 2>&1
   cd /opt/Laurux/sources && git clone 'https://github.com/Laurux/Laurux-Pos' >/root/laurux-pos_sources.log 2>&1
   cd /opt/Laurux/sources && git clone 'https://github.com/Laurux/LX-Pos' >/root/lx-pos_sources.log 2>&1
   echo "Downloading Laurux binary and data (/opt/Laurux/Laurux3)"
   cd /opt/Laurux && wget http://www.laurux.fr//file/Laurux3.tar.gz >/root/laurux.log 2>&1
   cd /opt/Laurux && tar xzvf Laurux3.tar.gz >>/root/laurux.log 2>&1
   /bin/touch /root/firstrun.done
   echo "Firstrun tasks done"
fi

exit 0
