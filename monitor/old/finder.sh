#!/bin/bash
. /etc/profile
. ~/.bash_profile
timeStr=`date +%Y%m%d`
FilePath=
LogFile=
ctime=-5  #-n，n分钟以内。n，n分钟之前



exec 1>> $LogFile
exec 2>> $LogFile
msg=`find $FilePath -type f -cmin $ctime | xargs ls -l`
count=`echo "$msg" | wc -l`

echo "+$(date +%Y-%m-%d\ %H:%M:%S) $count"
echo "$(date +%Y-%m-%d\ %H:%M:%S)"
echo "$msg"
