#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
POPS="$1"
GetInfo(){
        cmd=$1
        msg=`/usr/local/bin/pdsh -w 10.136.16.[16-20] -l twbjr ${cmd}; \
             /usr/local/bin/pdsh -w 10.136.16.[21-25] -l swbjr ${cmd}; \
             /usr/local/bin/pdsh -w 10.136.16.[26-47] -l jr ${cmd}; \
             /usr/local/bin/pdsh -w 10.136.64.[28-45] ${cmd}; \
             /usr/local/bin/pdsh -w 10.136.65.[16-51] ${cmd}; \
             /usr/local/bin/pdsh -w 10.136.47.[40-41] -l ywjr ${cmd}; \
             /usr/local/bin/pdsh -w 10.136.130.[161-190] -l dpl ${cmd}`
        echo "$msg"
}
GetInfo "uptime"
echo "$msg" | awk -F ":" -v POPS=$POPS 'BEFIN{
	end = "\033[0m"
        red = "\033[1;31m"
        green = "\033[1;32m"
        yellow = "\033[1;33m"
        blue = "\033[1;34m"
        purple = "\033[1;35m"
        wathet = "\033[1;36m"
}
{
	INFO[$1] = $NF
}
END{
	for(key in INFO){
		print key"    "INFO[key]
	}
}'






