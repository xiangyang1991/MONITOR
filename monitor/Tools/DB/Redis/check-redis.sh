#!/bin/bash
timeStr=`date -d "1 days ago" +%Y%m%d`
group=`ssh 10.136.64.38 /home/ycl/install/redis/redis-cli -p 6379 -n 2 get twx_g_ct_send_time_${timeStr}`
ivr=`ssh 10.136.64.38 /home/ycl/install/redis/redis-cli -p 6379 -n 2 get twx_ivr_ct_send_time_${timeStr}`
user=`ssh 10.136.64.38 /home/ycl/install/redis/redis-cli -p 6379 -n 2 get twx_user_allcount_${timeStr}`
echo "群发：$group"
echo "交互：$ivr"
echo "用户：$user"
