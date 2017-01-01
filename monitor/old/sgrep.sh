#!/bin/bash
LogFile="/home/ycl/sgrep.log"
exec 1>> $LogFile
exec 2>> $LogFile
HomeDir=/mnt/data/wxmsg/data

arr=(
	${HomeDir}/pa_callback_tran
	${HomeDir}/pa_gmsg_tran
	${HomeDir}/pa_ivrmsg_tran
)
msg="http://mp.weixin.qq.com/s?__biz=MzIwNzYyOTUzMw==&mid=2247483964&idx=3&sn=2f6a20a3dcb0d0d0efc4970eed681570&chksm=970e3f8ea079b6987e13c9367ed21530d147c8799311d2b77bd5e4aafa032f247524cb96fb05#rd"
for i in ${arr[@]}
do
	echo $i
	cd $i
	for j in `ls`
	do
		echo $j
		grep "$msg" $j
	done
done
