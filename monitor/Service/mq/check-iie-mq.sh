#!/bin/bash
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
current_time=`date +%Y-%m-%d\ %H:%M:%S`
echo "-----------------------------------------------------------${current_time}-----------------------------------------------------------"
${mq}/mq.sh $1 | grep ^iie_* | grep CLUSTERING | sort -k 7 -nr
