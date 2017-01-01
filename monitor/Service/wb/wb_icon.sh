#!/bin/bash


if [ $# -lt 1 ]; then
	timeStr=`date +%Y-%m-%d`
else
	timeStr=$1
fi 

ssh twbjr@10.136.16.17 /home/twbjr/project/ban-ycl-twb-iconloader-1.0-SNAPSHOT/totalstat.sh $timeStr

