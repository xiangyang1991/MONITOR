#!/bin/bash

current_time=`date +%Y-%m-%d`
yesterday=`date -d "1 days ago" +%Y-%m-%d`
if [ $# -lt 1 ];then
    day="${current_time}"
else
    day="${yesterday}"
fi
/usr/bin/expect -c "
spawn ssh mpp2@10.136.139.19 /home/mpp2/mpp-engine/monitor/mpp-count.sh $day
expect \"*password:*\"
send \"liuge1\r\"
interact
"
