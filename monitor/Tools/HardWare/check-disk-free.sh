#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
POPS="$1"
if [ $# -gt 0 ] && [ "$1" != "all" ]; then
	AllInfoUsage
fi
msg=`GetInfo "df -h" 2>/dev/null` 
msg=`echo "$msg" | grep -w "/" | awk -F "%" '{print $1"\t"$2}' | sort -k 6 -nr`
echo "$msg" | awk -v POPS=$POPS 'BEGIN{
        end = "\033[0m"
        red = "\033[1;31m"
        green = "\033[1;32m"
        yellow = "\033[1;33m"
        blue = "\033[1;34m"
        purple = "\033[1;35m"
        wathet = "\033[1;36m"
	HEADER = sprintf("%-20s%-16s%-8s%-8s%-8s%-8s","IP","Filesystem","Size","Avail","Use%","Mountde on")
	print purple HEADER end
}
{
        if($6 > 90){
		ERROR[$1] = sprintf("%-20s%-16s%-8s%-8s%-8s%-8s",$1,$2,$3,$5,$6"%",$7)
        }else if($6 > 85){
		WARN[$1] = sprintf("%-20s%-16s%-8s%-8s%-8s%-8s",$1,$2,$3,$5,$6"%",$7)
        }else{
		INFO[$1] = sprintf("%-20s%-16s%-8s%-8s%-8s%-8s",$1,$2,$3,$5,$6"%",$7)
        }       
}
END{
	for(key in ERROR){
		print red ERROR[key] end
	}
	for(key in WARN){
		print yellow WARN[key] end
	}
	if(POPS == "all"){
		for(key in INFO){
			print green INFO[key] end
		}
	}
}'
