#!/bin/bash
time=`date +"%Y-%m-%d"`
echo "$time"
intime=$1
if [ $time == $intime ]
then
	/home/ycl/monitor/Service/mongo/mongo 10.136.139.21:23456/docinfo /home/ycl/monitor/Service/mongo/js/countt.js   
	/home/ycl/monitor/Service/mongo/mongo 10.136.139.21:23456/docinfo /home/ycl/monitor/Service/mongo/js/countywt.js       
else
	/home/ycl/monitor/Service/mongo/mongo 10.136.139.21:23456/docinfo /home/ycl/monitor/Service/mongo/js/county.js
        /home/ycl/monitor/Service/mongo/mongo 10.136.139.21:23456/docinfo /home/ycl/monitor/Service/mongo/js/countywy.js
fi
exit




