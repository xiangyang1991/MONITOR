#!/bin/bash
. ~/.bash_profile
current_time=`date +%Y-%m-%d\ %H:%M:%S`
echo "-----------------------------------------------------------${current_time}-----------------------------------------------------------"
~/install/alibaba-rocketmq/bin/mqadmin consumerProgress -n "10.136.64.28:9877;10.136.64.29:9877;10.136.64.30:9877;10.136.64.31:9877;10.136.64.32:9877" \
	| grep ^ict_* | grep CLUSTERING | sort -k 7 -nr
