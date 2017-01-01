#!/bin/bash
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
current_time=`date +%Y-%m-%d`
yesterday=`date -d "1 days ago" +%Y-%m-%d`
cache_file="${MongoDB}/.cache/data2mongo.${yesterday}"
if [ -f ${cache_file} ];then
    cat ${cache_file}
else
    res=`ssh mongodb@10.136.139.21 "/home/mongodb/mongodb-3.2.9/bin/mongo 10.136.139.21:23456 /home/mongodb/ycl-datacount/weibo_yw.js"`
    echo "${res}" | tee ${cache_file}
fi
