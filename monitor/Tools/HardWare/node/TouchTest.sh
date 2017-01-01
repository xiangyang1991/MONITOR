#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
end="\033[0m"
red="\033[1;31m"
for i in `mount | grep "type ext" | grep -v "\/boot" | grep -w -v  "/" | grep -v "cdrom" | grep -v "/mnt/bb" | grep -v "/mnt/up" | awk '{print $3}'`; do 
	msg=`touch $i/TouchTest.file 2>&1`
		if [ $? -ne 0 ]; then
			echo -e "${red}$i${end}  $msg"
		fi
done
