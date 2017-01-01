#!/bin/bash
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
CacheDir="${mq}/.cache"
recount_sig=`find ${CacheDir} -type f -cmin ${FindTime} -name mq.cacheFile | wc -l`
CacheFile="${mq}/.cache/mq.cacheFile"
if [ ${recount_sig} -gt 0 ] && [ "$1" != "recount" ]; then
	cat ${CacheFile}
else
	times=0
	while :
	do
		let times=$times+1
		msg=`~/install/alibaba-rocketmq/bin/mqadmin consumerProgress -n \
		"10.136.64.28:9877;10.136.64.29:9877;10.136.64.30:9877;10.136.64.31:9877;10.136.64.32:9877" \
		| grep "CLUSTERING"`
		if [ $? -eq 0 ] || [ $times -gt 5 ]; then
			break
		fi
		sleep 5
	done
	echo "$msg" | tee ${CacheFile}
fi
