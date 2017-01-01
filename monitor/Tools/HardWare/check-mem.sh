#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
POPS="$1"
msg=`GetInfo "free -k | grep \"Mem\"" | awk '{print $0" "$4/$3}' | sort -k 9 -nr`
echo "$msg" | awk -v POPS=$POPS 'BEGIN{
	end = "\033[0m"
	red = "\033[1;31m"
	green = "\033[1;32m"
	yellow = "\033[1;33m"
	blue = "\033[1;34m"
	purple = "\033[1;35m"
	wathet = "\033[1;36m"
	HEADER = sprintf("%-20s%-12s%-12s%-12s","IP","内存总量","内存剩余","使用率")
	print HEADER
}
{
	if($4/$3 > 0.95){
                ERROR[$1] = sprintf("%-20s%-16s%-16s%-16s",$1,$3/1024/1024"G",$5/1024/1024"G",$4/$3*100"%");
	}else if($4/$3 > 0.85){
                WARN[$1] = sprintf("%-20s%-16s%-16s%-16s",$1,$3/1024/1024"G",$5/1024/1024"G",$4/$3*100"%");
	}else{
                INFO[$1] = sprintf("%-20s%-16s%-16s%-16s",$1,$3/1024/1024"G",$5/1024/1024"G",$4/$3*100"%");
	}	
}
END{
	for(key in ERROR){
		print red ERROR[key] end
	}
	if(POPS == "all"){
		for(key in WARN){
			print yellow WARN[key] end
		}
		for(key in INFO){
			print green INFO[key] end
		}
	}
}'
