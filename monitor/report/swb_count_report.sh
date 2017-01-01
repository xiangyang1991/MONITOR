#!/bin/bash
#该脚本原位置10.136.64.38 /home/ycl/project/ban-ycl-wb-cleaner/swb_count.sh
. /etc/profile
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
if [ $# -lt 1 ];then
  timeStr=`date +%Y-%m-%d`  
else 
  timeStr=$1
fi

echo "count time:$timeStr"

receiver=`/usr/local/bin/pdsh -w 10.136.65.16 "sh ~/.bash_profile;~/project/ban-ycl-wb-receivers-1.0.0/stat.sh \"$timeStr\""`
receiverRMsg=`echo ${receiver} |cut -d ' ' -f 3`
receiverSMsg=`echo ${receiver} |cut -d ' ' -f 4`
receiverDMsg=`echo ${receiver} |cut -d ' ' -f 5`
receiverRUser=`echo ${receiver} |cut -d ' ' -f 8`
receiverSUser=`echo ${receiver} |cut -d ' ' -f 9`
receiverDUser=`echo ${receiver} |cut -d ' ' -f 10`
#在本机执行不要加双引号，截取值是2,3,4;换节点截取值是3,4,5
cleaner=`/usr/local/bin/pdsh -w 10.136.64.38 "sh ~/.bash_profile;~/project/ban-ycl-wb-cleaner/swb_cleaner_count.sh \"$timeStr\""`
cleanerRMsg=`echo ${cleaner} |cut -d ' ' -f 2`
cleanerSMsg=`echo ${cleaner} |cut -d ' ' -f 3`
cleanerDMsg=`echo ${cleaner} |cut -d ' ' -f 4`

pic=`/usr/local/bin/pdsh -w 10.136.65.28 "sh ~/.bash_profile;~/project/ban-ycl-pic2st-1.0-SNAPSHOT/bin/statAll.sh \"$timeStr\"|awk 'NR==1{print}'"`
picR=`echo ${pic} |cut -d ' ' -f 3`
picS=`echo ${pic} |cut -d ' ' -f 4`
picP=`echo ${pic} |cut -d ' ' -f 5`
picD=`echo ${pic} |cut -d ' ' -f 6`

mongo=`/usr/local/bin/pdsh -w 10.136.65.34 "sh ~/.bash_profile;~/project/ban-ycl-wb-data2mongodb/bin/checktotal.sh \"$timeStr\""`
mongoRMsg=`echo ${mongo} |cut -d ' ' -f 3`
mongoSMsg=`echo ${mongo} |cut -d ' ' -f 4`
mongoDMsg=`echo ${mongo} |cut -d ' ' -f 5`
mongoRUser=`echo ${mongo} |cut -d ' ' -f 8`
mongoSUser=`echo ${mongo} |cut -d ' ' -f 9`
mongoDUser=`echo ${mongo} |cut -d ' ' -f 10`

		
		
newMongo=`/usr/local/bin/pdsh -w 10.136.65.45 "sh ~/.bash_profile;~/project/ban-ycl-wb-data2mongodbict/bin/schecktotal.sh \"$timeStr\""`
newMongoRMsg=`echo ${newMongo} |cut -d ' ' -f 3`
newMongoSMsg=`echo ${newMongo} |cut -d ' ' -f 4`
newMongoDMsg=`echo ${newMongo} |cut -d ' ' -f 5`
newMongoRUser=`echo ${newMongo} |cut -d ' ' -f 8`
newMongoSUser=`echo ${newMongo} |cut -d ' ' -f 9`
newMongoDUser=`echo ${newMongo} |cut -d ' ' -f 10`

lwb=`/usr/local/bin/pdsh -w 10.136.65.20  /home/ycl/project/ban-ycl-wb-user2mongodb/bin/schecktotal.sh \"$timeStr\" |awk 'NR==2{print}'`
lwbR=`echo ${lwb} |awk -F ' ' '{print $3}'`
lwbS=`echo ${lwb} |awk -F ' ' '{print $4}'`
lwbP=`echo ${lwb} |awk -F ' ' '{print $5}'`

#dataLoad2Mpp.sh 2016-12-13
#wb_sina: 36211960       36207639       
#wb_tenc: 1159900        1159900        
#wxjh: 1027898        1027898        
#wxqf: 713660         713522
msgLoad=`${MppLoad}/dataLoad2Mpp.sh $timeStr recount | grep "wb"`
Load2mppRece=`echo "${msgLoad}" | grep "wb_sina" | awk '{print $2}'`
Load2mppSend=`echo "${msgLoad}" | grep "wb_sina" | awk '{print $3}'`
Load2mppDiff=`echo "${msgLoad}" | grep "wb_sina" | awk '{print $4}'`



msg_icon=`${Swb}/wb_icon.sh $timeStr`
icon_rece=`echo "$msg_icon" | grep -w "swb_icon" | awk '{print $2}'`
icon_send=`echo "$msg_icon" | grep -w "swb_icon" | awk '{print $3}'`
icon_diff=`echo "$msg_icon" | grep -w "swb_icon" | awk '{print $4}'`



printf "===================新浪微博消息===================================\n"
printf "                  接收           发送           DiffTotal         \n"
printf "       数据接收    %-15s%-15s%-15s\n" ${receiverRMsg} ${receiverSMsg} ${receiverDMsg}
printf "       数据去重    %-15s%-15s%-15s\n" ${cleanerRMsg} ${cleanerSMsg} ${cleanerDMsg}
printf "mongo加载[老库]    %-15s%-15s%-15s\n" ${mongoRMsg} ${mongoSMsg} ${mongoDMsg}
printf "mongo加载[新库]    %-15s%-15s%-15s\n" ${newMongoRMsg} ${newMongoSMsg} ${newMongoDMsg}
printf "        mpp加载    %-15s%-15s%-15s\n" ${Load2mppRece} ${Load2mppSend} ${Load2mppDiff}
printf "     长微博入库    %-15s%-15s%-15s\n" ${lwbR} ${lwbS} ${lwbP}
printf "==================================================================\n"
printf "                   %-15s%-15s%-15s\n" "拉取量"           "下载量"          "DiffTotal"
printf "       头像        %-15s%-15s%-15s\n"  ${icon_rece}     ${icon_send}    ${icon_diff}
echo "                   接收           发送           下载           DiffTotal         "
printf "       数据图片    %-15s%-15s%-15s%-15s%-15s\n"  ${picR}      ${picS} ${picP} ${picD}
printf "===================新浪微博用户===================================\n"
printf "                   接收           发送           DiffTotal\n"
printf "       数据接收    %-15s%-15s%-15s\n" ${receiverRUser} ${receiverSUser} ${receiverDUser}
printf "mongo加载[老库]    %-15s%-15s%-15s\n" ${mongoRUser} ${mongoSUser} ${mongoDUser}
printf "mongo加载[新库]    %-15s%-15s%-15s\n" ${newMongoRUser} ${newMongoSUser} ${newMongoDUser}
