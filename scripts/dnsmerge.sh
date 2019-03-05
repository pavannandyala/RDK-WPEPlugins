#!/bin/sh
##########################################################################
# If not stated otherwise in this file or this component's Licenses.txt
# file the following copyright and licenses apply:
#
# Copyright 2016 RDK Management
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

resolvFile=/etc/resolv.dnsmasq
udhcpc_resolvfile=/tmp/resolv.dnsmasq.udhcpc
composite_resolvFile=/tmp/resolv.dnsmasq.bak
upnp_resolvFile=/tmp/resolv.dnsmasq.upnp

:>$composite_resolvFile #empty contents of resolvFile

for resolver in `ls /tmp/resolv.dnsmasq.* | grep -v $composite_resolvFile`
do
   if [ $resolver = $udhcpc_resolvfile ]  && [ -s $upnp_resolvFile ]; then
      continue
   fi
   if [ ! -s $composite_resolvFile ]; then
      cp $resolver $composite_resolvFile
   else
     awk 'NR==FNR{a[$0];next} !($0 in a)' $composite_resolvFile  $resolver >> $composite_resolvFile 
   fi
done

if [ ! -s $composite_resolvFile ]; then
   cp $udhcpc_resolvfile $composite_resolvFile
fi

if diff $composite_resolvFile $resolvFile >/dev/null ; then 
    echo "No Change in DNS Servers" 
else
    if [ -s $composite_resolvFile ];then
         cat $composite_resolvFile > $resolvFile 
         echo "DNS Servers Updated" 
    fi
fi
