#!/bin/bash
#当第二个参数为recount时，重新查询
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE 
current_time=`date +%Y-%m-%d`
if [ $# -lt 1 ];then
	day=${current_time}
else
	day=$1
fi
CacheDir="${MppLoad}/.cache"
CacheFile="dataLoad2mpp.$day"
recount_sig=`find ${CacheDir} -type f -cmin ${FindTime} -name $CacheFile | wc -l`

if [ "$day" != "$current_time" ] && [ "$2" != "recount" ] && [ -f ${CacheDir}/${CacheFile} ]; then
	cat ${CacheDir}/${CacheFile}
elif [ ${recount_sig} -gt 0 ] && [ "$2" != "recount" ] && [ -f ${CacheDir}/${CacheFile} ]; then
	cat ${CacheDir}/${CacheFile}
else
	/usr/bin/expect -c "
	spawn ssh dpl@10.136.64.37 \"/home/dpl/project/mpp-bdap-loader/bin/checktotal.sh $day; cat /home/dpl/.tmpwb\"
	        expect \"password:\"
	        send \"dpl\r\"
	interact
	" | grep "mpp-" | grep -v ";" | awk 'BEGIN{
		rece_swb = 0
		rece_twb = 0
		rece_wxjh = 0
		rece_wxqf = 0
		send_swb = 0
		send_twb = 0
		send_wxjh = 0
		send_wxqf = 0
		diff_swb = 0
		diff_twb = 0
		diff_wxjh = 0
		diff_wxqf = 0
	}
	{
		if($1 ~ /^mpp-swb$/){
			send_swb += $3
			rece_swb += $2
			diff_swb += $NF
		}else if($1 ~ /^mpp-twb$/){
			send_twb += $3
			rece_twb += $2
			diff_twb += $NF
		}else if($1 ~ /^mpp-wxjh$/){
			send_wxjh += $3
			rece_wxjh += $2
			diff_wxjh += $NF
		}else if($1 ~ /^mpp-wxqf$/){
			send_wxqf += $3
			rece_wxqf += $2
			diff_wxqf += $NF
		}
	}
	END{
		printf("wb_sina: %-15s%-15s%-15s\n",rece_swb,send_swb,diff_swb)
		printf("wb_tenc: %-15s%-15s%-15s\n",rece_twb,send_twb,diff_twb)  
		printf("wxjh:    %-15s%-15s%-15s\n",rece_wxjh,send_wxjh,diff_wxjh)
		printf("wxqf:    %-15s%-15s%-15s\n",rece_wxqf,send_wxqf,diff_wxqf)
	}' | tee ${CacheDir}/${CacheFile}
fi
