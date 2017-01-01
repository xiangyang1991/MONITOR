#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
POPS="$1"

#msg=`GetInfo "uptime"`
msg=`cat msg`
echo "$msg" | awk -v POPS=$POPS 'BEGIN{
	end = "\033[0m"
        red = "\033[1;31m"
        green = "\033[1;32m"
        yellow = "\033[1;33m"
        blue = "\033[1;34m"
        purple = "\033[1;35m"
        wathet = "\033[1;36m"
}{
	if($0 !~ /days/){
		WARN[$1] = $0
		print red""$0" "end
	}else{
		OK[$1] = $0
	}
}END{

	for(key in WARN){
		print red""$0" "end
	}

	if(POPS == "all"){
		for(key in OK){
			print green" "OK[key]" "end
		}
	}	
}'





