#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
for i in `cat configfile`; do 
	msg=`cd $i 2>&1`
	if [ $? -ne 0 ]; then
		echo -e 


	touch $i/TouchTest.file 2>/dev/null
		if [ $? -ne 0 ]; then
			echo "$i can not touch"
		fi
done
