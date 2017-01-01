#!/bin/bash
#加载量
#微信入Mongo新库，加载量
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE

if [ $# -lt 1 ];then
	timestr=`date +%Y-%m-%d`
else
	timestr=$1
fi

CacheFile="${MongoLoad}/.cache/dataLoad2Mongo.${timestr}"

if [ -f ${CacheFile} ]&&[ "$2" != "recount" ];then
	cat ${CacheFile}
else
	msg=`pdsh -w 10.136.65.31 "/home/ycl/project/ban-ycl-wx-user2mongodb-1.0-SNAPSHOT/bin/statAll.sh ${timestr}"`
	echo "$msg" | awk 'BEGIN{
		user_receive = 0
		user_send = 0
		ivrmsg_receive = 0
		ivrmsg_send = 0
		gmsg_receive = 0
		gmsg_send = 0
	}
	{
		if($2 ~ /user/){
			if($3 ~ /receive/){
				user_receive += $NF
			}else if($3 ~ /send/){
				user_send += $NF
			}
		}else if($2 ~ /ivrmsg/){
			if($3 ~ /receive/){
				ivrmsg_receive += $NF
			}else if($3 ~ /send/){
				ivrmsg_send += $NF
			}
		
		}else if($2 ~ /gmsg/){
			if($3 ~ /receive/){
				gmsg_receive += $NF
			}else if($3 ~ /send/){
				gmsg_send += $NF
			}
		
		}
	}
	END{
		printf("===============入库程序==微信库（新库）================\n")
		printf("            接收量         发送量\n")
		printf("用户入库:   %-15s%-15s\n", user_receive, user_send)
		printf("交互入库:   %-15s%-15s\n", ivrmsg_receive, ivrmsg_send)
		printf("群发入库:   %-15s%-15s\n", gmsg_receive, gmsg_send)
	}' | tee ${CacheFile}
fi
