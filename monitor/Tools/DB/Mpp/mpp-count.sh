#!/bin/bash
#nodes="node175 node176 node177 node178 node179"
showUsage(){
        echo "geizhangmingcheng.sh  dataType"
}

if [ $# -lt 1 ]
then
    showUsage
     exit 0
fi
day=$1

#node=node169
node="10.136.130.180"
d1=`date -d $day +"%Y-%m-%d 00:00:00"`
d2=`date -d $day +"%Y-%m-%d 23:59:59"`
project_path="/home/mpp2/mpp-engine"
tables="tp_msg_microblog tp_msg_wechat_public_group tp_msg_wechat_public_interactive"
#port=`grep beeswax_port ~/mpp-engine/ice_config/global.ini |awk -F 'beeswax_port=' '{print $2}'|awk '{print $1}'`
port="21400"
db="db"

for i in $tables;do
	if [ $i == "tp_msg_microblog" ];then 
		sql="select count(*) from $i where m_publish_time>=unix_timestamp('$d1') and m_publish_time<unix_timestamp('$d2') and g_asp='TWeibo';"
		sql2=`impala-shell -i $node:$port -q "use db;$sql" | grep 'Connected\||\|Returned'`
		echo "table ${i}_tenc" $sql2 >> $day\.log
		sql="select count(*) from $i where m_publish_time>=unix_timestamp('$d1') and m_publish_time<unix_timestamp('$d2') and g_asp='Weibo';"
		sql2=`impala-shell -i $node:$port -q "use db;$sql" | grep 'Connected\||\|Returned'`
		echo "table ${i}_sina" $sql2 >> $day\.log
	elif [ $i=="tp_msg_wechat_public_group" ]||[ $i=="tp_msg_wechat_public_interactive" ];then
		sql="select count(*) from $i where m_insert_time>=unix_timestamp('$d1') and m_insert_time<unix_timestamp('$d2');"
		sql2=`impala-shell -i $node:$port -q "use db;$sql" | grep 'Connected\||\|Returned'`
		echo "table $i" $sql2 >> $day\.log
	else
		sql="select count(*) from $i where m_publish_time>=unix_timestamp('$d1') and m_publish_time<unix_timestamp('$d2');"
		sql2=`impala-shell -i $node:$port -q "use db;$sql" | grep 'Connected\||\|Returned'`
		echo "table $i" $sql2 >> $day\.log
	fi
done
cat $day\.log | awk '{print $1"\t"$2"\t"$10}'
#sed -i -e 's/ | count() | |//g' -e 's/ |//g' $day\.log
#echo ' ' >> $day\.log 
#cat $day\.log      
rm -rf $day\.log
