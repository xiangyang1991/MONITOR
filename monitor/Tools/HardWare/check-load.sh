#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
############


#############
RotateLine &
RotateLine_pid=$!

msg=`GetInfo "uptime"`
POPS="$1"
LOAD_OK=""
LOAD_WARN=5
LOAD_ERROR=10


###################################################################################################
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



###################################################################################################



echo "$msg" | awk \
	-v POPS=$POPS \
	-v LOAD_ERROR=$LOAD_ERROR \
	-v LOAD_WARN=$LOAD_WARN \
'
	function INSERT(arr, Index, str){
		arr[Index] = str
	}
	
	function APPEND(arr, times, str){
		for(i = 1; i <= times; i++){
			Index = length(arr) + 1
			arr[Index] = str
		}
	}

BEGIN{
	red = "\033[1;31m";
	green = "\033[1;32m";
	yellow = "\033[1;33m";
	purple = "\033[1;35m";
	end = "\033[0m";
	ERROR[sign] = 0
	delete ERROR[sign]
}
{
	split($0, tmp, ":")
	INSERT(MSGARR, tmp[1], tmp[length(tmp)])
}
END{
#	for(key in MSGARR){
#		printf("%s\t%s\n",key,MSGARR[key])
#	}

#set color & classify
	for(key in MSGARR){
		split(MSGARR[key], tmp, ",")
		for(tkey in tmp){
			if(tmp[tkey] >= LOAD_ERROR){
				tmp[tkey] = sprintf("%s%s%s", red, tmp[tkey], end)
#				tmp[length(tmp) + 1] = "!!"
				APPEND(tmp, 2, "!")
			}else if(tmp[tkey] >= LOAD_WARN){
				tmp[tkey] = sprintf("%s%s%s", yellow, tmp[tkey], end)
#				tmp[length(tmp) + 1] = "!"
				APPEND(tmp, 1, "!")
			}else{
				tmp[tkey] = sprintf("%s%s%s", green, tmp[tkey], end)
			}
		}
#format & insert in array		
		if(length(tmp) > 3){
			ERROR[key] = sprintf("%-30s%-30s%-30s",tmp[1], tmp[2], tmp[3])
		}else{
			OK[key] = sprintf("%-30s%-30s%-30s",tmp[1], tmp[2], tmp[3])
		}
	}

#print res	
	if(length(ERROR) != 0 || POPS == "all"){
		printf("%-21s%-19s%-19s%-19s\n", "   HOST IP  ", "1min", "5min", "15min")
	}else{
		printf(" %sLoad of all nodes are not more than %s%s%s,\n use \"%sall%s\" to show all nodes load average.%s\n" \
			,green, purple, LOAD_WARN, green, purple, green, end)
	}

	for(key in ERROR){
		printf("%-20s%s\n", key, ERROR[key])
	}
	
	if(POPS == "all"){
		
		for(key in OK){
			printf("%-20s%s\n", key, OK[key])
		}
	}
}'

kill -9 $RotateLine_pid
