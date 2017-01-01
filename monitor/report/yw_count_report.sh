#!/bin/bash
#该脚本已迁移到10.136.65.24:/home/ycl/monitor/Server/yw下
#修改功能请到10.136.65.24上修改
if [ $# -lt 1 ]
then
        echo "ywstat.sh yyyy-mm-dd"
        exit 0
fi

timeVar="$1"

timeStamp=`echo $timeVar|awk -F '-' '{print $1 $2 $3}'` 
acceptFileNum=`ssh ywjr@10.136.47.41 "/home/ywjr/project/ban-ywjr-server-1.0.0/bin/fileStat.sh '$timeVar'"`


echo "=========================每日要闻数据量统计========================="
echo "接收的文件数          $acceptFileNum"

ssh ycl@10.136.64.28 "/home/ycl/project/ban-ycl-yw-parser-1.0.0/bin/parserAllStat.sh '$timeVar'"
ssh ycl@10.136.64.34 "/home/ycl/project/ban-ycl-yw-mongodb/bin/mongoMppAllStat.sh '$timeVar'"

echo -e "\n"
ssh ycl@10.136.64.28 "/home/ycl/project/ban-ycl-yw-parser-1.0.0/bin/parserEvyStat.sh '$timeVar'"
echo -e "\n"
ssh ycl@10.136.64.34 "/home/ycl/project/ban-ycl-yw-mongodb/bin/mongoMppEvyStat.sh '$timeVar'"
