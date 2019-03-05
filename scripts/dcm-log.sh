#!/bin/sh

. /opt/dcm.properties
. /opt/device.properties
/bin/touch /opt/logs/dcmscript.log

if [ "$DEVICE_TYPE" == "mediaclient" ]; then 
echo "Not triggered" > /opt/loguploadstatus.txt; fi
/lib/rdk/StartDCM.sh $DCM_LOG_SERVER $DCM_LOG_SERVER_URL $LOG_SERVER 0 $DCM_SCP_SERVER
