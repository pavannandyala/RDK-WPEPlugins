#!/bin/sh

./etc/device.properties

if [ -f /opt/wifi/wpa_supplicant.conf ]; then 
sed -i "/bssid=/d" /opt/wifi/wpa_supplicant.conf; 
fi

if [ -f /opt/wifi/wpa_supplicant.conf ]; then 
sed -i "s/key_mgmt=OPEN/key_mgmt=NONE/g" /opt/wifi/wpa_supplicant.conf; 
fi

if [ "$BUILD_TYPE" != "prod" ]; then
/lib/rdk/opt-override.sh; 
fi

/usr/bin/netsrvmgr --configFilePath /etc/netsrvmgr.conf --debugconfig /etc/debug.ini
