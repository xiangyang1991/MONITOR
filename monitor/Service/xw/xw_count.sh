#!/bin/bash
. /etc/profile
. ~/.bash_profile

msg1=`ssh 10.136.65.38 /home/ycl/project/ban-ycl-jnnews-parser-1.0/bin/stat.sh $1`
NEWSGZ=`echo "$msg1" |awk 'NR==1{print}'`
NEWSFILE=`echo "$msg1" |awk 'NR==2{print}'`
NEWSSEND=`echo "$msg1" |awk 'NR==3{print}'`

NEWSJWREST=`/usr/local/bin/pdsh -w jr@10.136.16.28 /home/jr/project/ban-ycl-jwnews-rest-1.0.0/bin/stat.sh $1 |awk 'NR==3{print $2}'`

msg2=`/usr/local/bin/pdsh -w 10.136.65.42 /home/ycl/project/ban-ycl-jwnews-parser-1.0/bin/stat.sh $1`
NEWSJWPARSER1=`echo "$msg2" |awk 'NR==3{print $2}'`
NEWSJWPARSER2=`echo "$msg2" |awk 'NR==5{print $2}'`
NEWSJWPARSER3=`echo "$msg2" |awk 'NR==7{print $2}'`

msg3=`/usr/local/bin/pdsh -w 10.136.65.41 ~/project/ban-ycl-news-cleaner/360_news_count.sh $1`
NEWSCLEAN41=`echo "$msg3" |awk 'NR==2{printf("%-15s%-15s",$3,$4)}'`
#NEWSCLEAN42=`echo "$msg3" |awk 'NR==3{printf("%-15s%-15s",$3,$4)}'`
NEWSCLEAN42=`echo "$msg3" |awk 'BEGIN{sum1=0;sum2=0}{if($2=="10.136.65.42:"||$2=="10.136.65.50:"){sum1+=$3;sum2+=$4}}END{printf("%-15s%-15s",sum1,sum2)}'`
#NEWSCLEAN43=`echo "$msg3" |awk 'NR==4{printf("%-15s%-15s",$3,$4)}'`
NEWSCLEAN43=`echo "$msg3" |awk 'BEGIN{sum1=0;sum2=0}{if($2=="10.136.65.40:"||$2=="10.136.65.43:"){sum1+=$3;sum2+=$4}}END{printf("%-15s%-15s",sum1,sum2)}'`
NEWSCLEAN44=`echo "$msg3" |awk 'NR==5{printf("%-15s%-15s",$3,$4)}'`
NEWSCLEAN45=`echo "$msg3" |awk 'NR==6{printf("%-15s%-15s",$3,$4)}'`
NEWSCLEAN46=`echo "$msg3" |awk 'NR==7{printf("%-15s%-15s",$3,$4)}'`
NEWSCLEAN47=`echo "$msg3" |awk 'NR==8{printf("%-15s%-15s",$3,$4)}'`
NEWSCLEAN48=`echo "$msg3" |awk 'NR==9{printf("%-15s%-15s",$3,$4)}'`
NEWSCLEAN49=`echo "$msg3" |awk 'NR==10{printf("%-15s%-15s",$3,$4)}'`
#NEWSCLEAN50=`echo "$msg3" |awk 'NR==11{printf("%-15s%-15s",$3,$4)}'`
#NEWSCLEAN51=`echo "$msg3" |awk 'NR==11{printf("%-15s%-15s",$3,$4)}'`


msg4=`/usr/local/bin/pdsh -w 10.136.65.42 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB42R=`echo "$msg4" | awk 'NR==1{print $3}'`
MONGODB42S=`echo "$msg4" | awk 'NR==2{print $3}'`

msg5=`/usr/local/bin/pdsh -w 10.136.65.43 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB43R=`echo "$msg5" | awk 'NR==1{print $3}'`
MONGODB43S=`echo "$msg5" | awk 'NR==2{print $3}'`

msg6=`/usr/local/bin/pdsh -w 10.136.65.44 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB44R=`echo "$msg6" | awk 'NR==1{print $3}'`
MONGODB44S=`echo "$msg6" | awk 'NR==2{print $3}'`

msg7=`/usr/local/bin/pdsh -w 10.136.65.45 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB45R=`echo "$msg7" | awk 'NR==1{print $3}'`
MONGODB45S=`echo "$msg7" | awk 'NR==2{print $3}'`

msg8=`/usr/local/bin/pdsh -w 10.136.65.46 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB46R=`echo "$msg8" | awk 'NR==1{print $3}'`
MONGODB46S=`echo "$msg8" | awk 'NR==2{print $3}'`

msg9=`/usr/local/bin/pdsh -w 10.136.65.47 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB47R=`echo "$msg9" | awk 'NR==1{print $3}'`
MONGODB47S=`echo "$msg9" | awk 'NR==2{print $3}'`

msg10=`/usr/local/bin/pdsh -w 10.136.65.48 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB48R=`echo "$msg10" | awk 'NR==1{print $3}'`
MONGODB48S=`echo "$msg10" | awk 'NR==2{print $3}'`

msg11=`/usr/local/bin/pdsh -w 10.136.65.49 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB49R=`echo "$msg11" | awk 'NR==1{print $3}'`
MONGODB49S=`echo "$msg11" | awk 'NR==2{print $3}'`

msg12=`/usr/local/bin/pdsh -w 10.136.65.50 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB50R=`echo "$msg12" | awk 'NR==1{print $3}'`
MONGODB50S=`echo "$msg12" | awk 'NR==2{print $3}'`

msg13=`/usr/local/bin/pdsh -w 10.136.65.51 ~/project/ban-ycl-news2mongodb-1.0-SNAPSHOT/bin/stat.sh $1`
MONGODB51R=`echo "$msg13"| awk 'NR==1{print $3}'`
MONGODB51S=`echo "$msg13"| awk 'NR==2{print $3}'`

msg_mq=`/home/ycl/install/alibaba-rocketmq/bin/mqadmin consumerProgress -n "10.136.64.28:9877;10.136.64.29:9877;10.136.64.30:9877;10.136.64.31:9877;10.136.64.32:9877"`
DiffTotalRest=`echo "$msg_mq" | grep -w "iie_di_news_360jwnews_rest" | awk '{print $NF}'`
DiffTotal_ict_jwnews=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_ict_jwnews" | awk '{print $NF}'`
DiffTotal_ict_jnbbs=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_ict_jnbbs" | awk '{print $NF}'`
DiffTotal_ict_jnblogs=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_ict_jnblogs" | awk '{print $NF}'`
DiffTotal_jnnews_update=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_jnnews_update" | awk '{print $NF}'`
DiffTotal_jnbbs_update=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_jnbbs_update" | awk '{print $NF}'`
DiffTotal_360_jnnews=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_360_jnnews" | awk '{print $NF}'`
DiffTotal_360_jwnews=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_360_jwnews" | awk '{print $NF}'`
DiffTotal_ict_jnapp=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_ict_jnapp" | awk '{print $NF}'`
#DiffTotal_ict_jnbbspost=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_ict_jnbbspost" | awk '{print $NF}'`
DiffTotal_ict_jnnews=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_ict_jnnews" | awk '{print $NF}'`
#DiffTotal_ict_jnnewsremark=`echo "$msg_mq" | grep -w "iie_di_news_cleaner_ict_jnnewsremark" | awk '{print $NF}'`
DiffTotal_mongo_jw_news_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jw_news_2_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_news_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jn_news_2_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_blogs_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jn_blogs_2_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_bbs_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jn_bbs_2_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_360_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jn_360_2_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_apps_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jn_app_2_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_newsremark_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_ict_jn_newsremark_ori_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_bbspost_2_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_ict_jn_bbspost_ori_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_news_update_1_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jn_news_update_1_mq" | awk '{print $NF}'`
DiffTotal_mongo_jn_bbs_update_1_mq=`echo "$msg_mq" | grep -w "iie_di_news_mongo_jn_bbs_update_1_mq" | awk '{print $NF}'`


echo "===============境内新闻数据统计====================="
echo "                  数据量"
echo "解压文件个数    ${NEWSGZ}"
echo "解析文件条数    ${NEWSFILE}"
echo "解析文件条数    ${NEWSSEND}"
echo "===================================================="
echo "==============境外新闻数据统计======================"
echo "                  数据量             DiffTotal"
echo "境外REST接收条数  ${NEWSJWREST}               ${DiffTotalRest}"
echo "解析接收条数      ${NEWSJWPARSER1}"
echo "解析成功条数      ${NEWSJWPARSER2}"
echo "解析失败条数      ${NEWSJWPARSER3}" 
echo "===================================================="
echo "===================================新闻去重通道统计================================="
echo "                                          【去重前】     【去重后】     【DiffTotal】"
echo "[1]jn_news_update_ori_mq[境内新闻更新]     ${NEWSCLEAN41} ${DiffTotal_jnnews_update}"
echo "[2]jn_bbs_update_ori_mq[境内BBS更新]       ${NEWSCLEAN42} ${DiffTotal_jnbbs_update}"
echo "[3]   360_jnnews_0_mq  [360境内新闻]       ${NEWSCLEAN43} ${DiffTotal_360_jnnews}"
echo "[4]   360_jwnews_0_mq  [360境外新闻]       ${NEWSCLEAN44} ${DiffTotal_360_jwnews}"
echo "[5]  ict_jwnews_ori_mq [  ict境外  ]       ${NEWSCLEAN45} ${DiffTotal_ict_jwnews}"
echo "[6] ict_jn_news_ori_mq [  ict境内  ]       ${NEWSCLEAN46} ${DiffTotal_ict_jnnews}"
echo "[7] ict_jn_blogs_ori_mq[  ict博客  ]       ${NEWSCLEAN47} ${DiffTotal_ict_jnblogs}"
echo "[8] ict_jn_bbs_ori_mq  [  ict论坛  ]       ${NEWSCLEAN48} ${DiffTotal_ict_jnbbs}"
echo "[9] ict_jn_app_ori_mq  [  ict APPS ]       ${NEWSCLEAN49} ${DiffTotal_ict_jnapp}"
echo "===================================================================================="
echo "====================================新闻入库统计===================================="
echo "                                           接收量         发送量         DiffTotal"
printf "[1]  jw_news_2_mq[境外新闻]                %-15s%-15s%-15s\n" ${MONGODB42R} ${MONGODB42S} ${DiffTotal_mongo_jw_news_2_mq}
printf "[2]  jn_news_2_mq[境内新闻]                %-15s%-15s%-15s\n" ${MONGODB43R} ${MONGODB43S} ${DiffTotal_mongo_jn_news_2_mq}
printf "[3] jn_blogs_2_mq[境内博客]                %-15s%-15s%-15s\n" ${MONGODB44R} ${MONGODB44S} ${DiffTotal_mongo_jn_blogs_2_mq}
printf "[4]  jn_bbs_2_mq [境内论坛]                %-15s%-15s%-15s\n" ${MONGODB45R} ${MONGODB45S} ${DiffTotal_mongo_jn_bbs_2_mq}
printf "[5]  jn_360_2_mq [境内360]                 %-15s%-15s%-15s\n" ${MONGODB46R} ${MONGODB46S} ${DiffTotal_mongo_jn_360_2_mq}
printf "[6] jn_apps_2_mq [境内APP]                 %-15s%-15s%-15s\n" ${MONGODB47R} ${MONGODB47S} ${DiffTotal_mongo_jn_apps_2_mq}
printf "[7] jn_newsremark_2_mq[评论]               %-15s%-15s%-15s\n" ${MONGODB48R} ${MONGODB48S} ${DiffTotal_mongo_jn_newsremark_2_mq}
printf "[8] jn_bbspost_2_mq [回帖]                 %-15s%-15s%-15s\n" ${MONGODB49R} ${MONGODB49S} ${DiffTotal_mongo_jn_bbspost_2_mq}
printf "[9] jn_news_update_2_mq[更新1]             %-15s%-15s%-15s\n" ${MONGODB50R} ${MONGODB50S} ${DiffTotal_mongo_jn_news_update_1_mq}
printf "[10] jn_bbs_update_2_mq[更新2]             %-15s%-15s%-15s\n" ${MONGODB51R} ${MONGODB51S} ${DiffTotal_mongo_jn_bbs_update_1_mq}
echo "===================================================================================="
