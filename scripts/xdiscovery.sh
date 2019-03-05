#!/bin/sh

/usr/bin/xdiscovery /etc/xdiscovery.conf
if [ -f /lib/rdk/updateFireWall.sh ]; then 
/bin/sh /lib/rdk/updateFireWall.sh xdiscovery ; 
fi
