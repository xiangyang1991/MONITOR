#!/bin/bash
. /etc/profile 2> /dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
current_time=`date +%Y-%m-%d`
if [ $# != 1 ];then
	timeStr=$current_time
else
	timeStr=$1
fi


msg1=`/usr/local/bin/pdsh -w 10.136.65.28 ~/project/ban-ycl-wx-cleaner/twx_cleaner_count.sh $timeStr`
cleanerIMSG=`echo "$msg1" |awk 'NR==1{printf("%-15s%-15s%-15s%-15s\n",$3,$4,$5,$6)}'`
cleanerGMSG=`echo "$msg1" |awk 'NR==2{printf("%-15s%-15s%-15s%-15s\n",$3,$4,$5,$6)}'`

msg2=`/usr/local/bin/pdsh -w 10.136.65.[27,28] ~/project/ban-ycl-wx-data2mongodb-1.0-SNAPSHOT/bin/stat.sh $timeStr`
imsgR=`echo "$msg2" | grep receive | awk 'BEGIN{sum=0}{sum=sum+$3}END{print "receive " sum}' | awk 'NR==1{print $2}'`
imsgS=`echo "$msg2" | grep send | awk 'BEGIN{sum=0}{sum=sum+$3}END{print "receive " sum}' | awk 'NR==1{print $2}'`

msg3=`/usr/local/bin/pdsh -w 10.136.65.[29,30] ~/project/ban-ycl-wx-data2mongodb-1.0-SNAPSHOT/bin/stat.sh $timeStr`
gmsgR=`echo "$msg3" |grep receive |awk 'BEGIN{sum=0}{sum=sum+$3}END{print "receive " sum}' | awk 'NR==1{print $2}'`
gmsgS=`echo "$msg3" |grep send |awk 'BEGIN{sum=0}{sum=sum+$3}END{print "receive " sum}' | awk 'NR==1{print $2}'`

msg4=`/usr/local/bin/pdsh -w 10.136.65.[24-26] ~/project/ban-ycl-wx-user2mongodb-1.0-SNAPSHOT/bin/stat_1.sh $timeStr`
userR=`echo "$msg4" |grep receive |awk 'BEGIN{sum=0}{sum=sum+$3}END{print "receive " sum}'| awk 'NR==1{print $2}'`
userS=`echo "$msg4" |grep send |awk 'BEGIN{sum=0}{sum=sum+$3}END{print "receive " sum}'| awk 'NR==1{print $2}'`

msg_mq=`/home/ycl/install/alibaba-rocketmq/bin/mqadmin consumerProgress -n "10.136.64.28:9877;10.136.64.29:9877;10.136.64.30:9877;10.136.64.31:9877;10.136.64.32:9877"\
	| grep "CLUSTERING"`
DiffCleanerimsg=`echo "$msg_mq" | grep -w iie_di_twx_cleaner_ivrmsg | awk '{print $NF}'`
DiffCleanergmsg=`echo "$msg_mq" | grep iie_di_twx_cleaner_gmsg | awk '{print $NF}'`
DiffMongoimsg=`echo "$msg_mq" | grep iie_di_twx_mongo_ivrmsg | awk '{print $NF}'`
DiffMongogmsg=`echo "$msg_mq" | grep iie_di_twx_mongo_gmsg | awk '{print $NF}'`
DiffMongouser=`echo "$msg_mq" | grep iie_di_twx_mongo_user | awk '{print $NF}'`


#wxjh:    1590803        1590803        0              
#wxqf:    527060         526655         0

Load2mppMsg=`${MppLoad}/dataLoad2Mpp.sh $timeStr recount`
Load2mppMsg_gro_rece=`echo "${Load2mppMsg}" | grep "wxqf" | awk '{print $2}'`
Load2mppMsg_gro_send=`echo "${Load2mppMsg}" | grep "wxqf" | awk '{print $3}'`
Load2mppMsg_gro_diff=`echo "${Load2mppMsg}" | grep "wxqf" | awk '{print $4}'`
Load2mppMsg_ivr_rece=`echo "${Load2mppMsg}" | grep "wxjh" | awk '{print $2}'`
Load2mppMsg_ivr_send=`echo "${Load2mppMsg}" | grep "wxjh" | awk '{print $3}'`
Load2mppMsg_ivr_diff=`echo "${Load2mppMsg}" | grep "wxjh" | awk '{print $4}'`

msg_ict=`ssh 10.136.65.29 "/home/ycl/monitor/check-status.sh $timeStr"`
msg_ict_user_time=`echo "$msg_ict" | grep "user" | awk '{print $2}'`
msg_ict_user_stat=`echo "$msg_ict" | grep "user" | awk '{print $3}'`
msg_ict_msg_time=`echo "$msg_ict" | grep "msg" | awk '{print $2}'`
msg_ict_msg_stat=`echo "$msg_ict" | grep "msg" | awk '{print $3}'`

echo =======================微信解析程序====================
echo "                     【解析文件条数】【发送成功条数】"
/home/ycl/project/ban-ycl-wx-parser-1.0/bin/historystat.sh $timeStr

echo =======================================================

echo ============================去重程序===========================
#$cleaner=`/usr/local/bin/pdsh -w 10.136.65.28 ~/project/ban-ycl-cleaner/twx_cleaner_count.sh $1`
echo "          【去重前】     【去重后】     【清洗后】       【垃圾】          【DiffTotal】"
echo "交互数据    ${cleanerIMSG}   ${DiffCleanerimsg}"
echo "群发数据    ${cleanerGMSG}   ${DiffCleanergmsg}"
echo ====================入库程序==舆情库（老库）===================
printf "            %-15s%-15s%-15s\n" "接收量" "发送量" "DiffTotal"
printf "群发入库    %-15s%-15s%-15s\n" ${gmsgR} ${gmsgS} ${DiffMongogmsg}
printf "交互入库    %-15s%-15s%-15s\n" ${imsgR} ${imsgS} ${DiffMongoimsg}
printf "用户入库    %-15s%-15s%-15s\n" ${userR} ${userS} ${DiffMongouser}
/home/ycl/tools/monitor/Load/check-wx-data2mongoDB-new_1.sh $timeStr
echo =========================Mpp加载量=====================
printf "            %-15s%-15s%-15s\n" "接收量" "发送量" "DiffTotal"
printf "群发入库    %-15s%-15s%-15s\n" ${Load2mppMsg_gro_rece} ${Load2mppMsg_gro_send} ${Load2mppMsg_gro_diff}
printf "交互入库    %-15s%-15s%-15s\n" ${Load2mppMsg_ivr_rece} ${Load2mppMsg_ivr_send} ${Load2mppMsg_ivr_diff}
echo =======================调用计算所接口==================
printf "                        %-15s%-15s\n"  "时间" "状态"
printf "调用计算所消息接口   %-15s%-15s\n" ${msg_ict_msg_time} ${msg_ict_msg_stat}
printf "调用计算所用户接口   %-15s%-15s\n"  ${msg_ict_user_time} ${msg_ict_user_stat}
