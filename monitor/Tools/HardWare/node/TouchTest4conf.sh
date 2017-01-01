#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
home_dir=$(cd `dirname $0`; pwd)
testfile="`hostname`_availableTest"
end="\033[0m"
red="\033[1;31m"
for i in `cat ${home_dir}/.disk_check_config`; do 
	msg=`cd $i 2>&1`
	if [ $? -ne 0 ]; then
		echo -e "${red}$i$end  $msg"
	else
		msg=`touch $i/${testfile} 2>&1`
			if [ $? -ne 0 ]; then
				echo -e "${red}$i${end}  $msg"
			fi
	fi
done
