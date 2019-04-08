#!/bin/sh

export RMF_OSAL_THREAD_INFO_CALL_PORT=54128
/bin/mkdir -p /opt/persistent/usr/1112/703e
/bin/touch /opt/persistent/dtcp.srm
cd /usr/bin/
./rmfStreamer
