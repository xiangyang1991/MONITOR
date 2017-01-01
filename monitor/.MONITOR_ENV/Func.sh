#!/bin/bash
. /etc/profile 2>/dev/null 
. ~/.bash_profile
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

AllInfoUsage(){
	echo "	Usage: use all for all info"
}

RotateLine(){
        INTERVAL=0.15
        TCOUNT=0

        while :; do
                TCOUNT=`expr $TCOUNT + 1`

                case $TCOUNT in
                        "1") echo -e '-'"\b\c"
                                sleep $INTERVAL
                                ;;
                        "2") echo -e '\\'"\b\c"
                                sleep $INTERVAL
                                ;;
                        "3") echo -e "|\b\c"
                                sleep $INTERVAL
                                ;;
                        "4") echo -e "/\b\c"
                                sleep $INTERVAL
                                ;;
                        *) TCOUNT='0'
                                ;;
                esac
        done
}
