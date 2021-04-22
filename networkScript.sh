#!/bin/bash

# parameter in frameworks should be 25,000
# selectiveforwarding.communicator.queuesize=25000
# parameter in nva.conf should be 200,000
# SELECTIVE_FORWARDING_PROXY_QUEUE_CAPACITY=200000

nva_file="/opt/qradar/conf/nva.conf"
frameworks_file="/opt/qradar/conf/frameworks.properties"
# The variable holds the parametr within nva.conf file
queue_capacity=$(cat $nva_file | grep -i "SELECTIVE_FORWARDING_PROXY_QUEUE_CAPACITY")
# The variable holds the parametr within frameworks.properties file
queue_size=$(cat $frameworks_file | grep -i "selectiveforwarding.communicator.queuesize")

echo $queue_capacity
if [ $queue_capacity != "SELECTIVE_FORWARDING_PROXY_QUEUE_CAPACITY=200000" ]; then
# Edit nva.conf and replace the SELECTIVE_FORWARDING_PROXY_QUEUE_CAPACITY parameter number with 200,000
	vim $nva_file
else
	echo "The file holds the desire parameter"
fi

echo $queue_size

if [ $queue_size != "selectiveforwarding.communicator.queuesize=25000" ]; then
	vim $frameworks_file
else 
	echo "The file holds the desire parameter"
fi

# Restart the Hostcontext service
systemctl restart hostcontext

echo "hostcontext service has been restarted"

# TCPDump to see if there are connection
tcpdump -nnA -i any dst host xxxxxxxxxxxx

