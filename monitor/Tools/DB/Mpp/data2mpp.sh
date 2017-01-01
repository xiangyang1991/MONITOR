#!/bin/bash
#use recount as $2 to recount
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
current_time=`date +%Y-%m-%d`
if [ $# -lt 1 ]; then
    day="${current_time}"
else
    day="${1}"
fi

if [ -f $MppDB/.cache/data2mpp.${day} ] && [ "$2" != "recount" ]; then
	cat $MppDB/.cache/data2mpp.${day}
else
	${MppDB}/mpp-count.sh ${day} \
	| grep -w "table" | awk 'BEGIN{
	        tp_msg_microblog_tenc = 0
	        tp_msg_microblog_sina = 0
	        tp_msg_wechat_public_group = 0
	        tp_msg_wechat_public_interactive = 0
	}
	{
	        if($2 ~ /msg_microblog_tenc/){
	                tp_msg_microblog_tenc += $NF
	        }else if($2 ~ /msg_microblog_sina/){
	                tp_msg_microblog_sina += $NF
	        }else if($2 ~ /msg_wechat_public_group/){
	                tp_msg_wechat_public_group += $NF
	        }else if($2 ~ /msg_wechat_public_interactive/){
	                tp_msg_wechat_public_interactive += $NF
	        }
	}
	END{
	        printf("腾讯微博: %-15s\n",tp_msg_microblog_tenc)
	        printf("新浪微博: %-15s\n",tp_msg_microblog_sina)
	        printf("微信群发: %-15s\n",tp_msg_wechat_public_group)
	        printf("微信交互: %-15s\n",tp_msg_wechat_public_interactive)
	}' | tee $MppDB/.cache/data2mpp.${day}
fi
