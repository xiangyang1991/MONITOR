#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
msg=`GetInfo "df -h"`
echo "$msg" | awk '{
	if($2 ~ /\/dev\//){
		if($7 !~ /boot/){
			if($7 !~ /^\/$/){
				if($7 !~ /cdrom/){
					print
				}
			}
		}
	}

}'
