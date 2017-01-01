#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE

#GetInfo(){
#        cmd=$1
#        msg=`/usr/local/bin/pdsh -w 10.136.16.[16-20] -l twbjr ${cmd}; \
#             /usr/local/bin/pdsh -w 10.136.16.[21-25] -l swbjr ${cmd}; \
#             /usr/local/bin/pdsh -w 10.136.16.[26-47] -l jr ${cmd}; \
#             /usr/local/bin/pdsh -w 10.136.64.[28-45] ${cmd}; \
#             /usr/local/bin/pdsh -w 10.136.65.[16-51] ${cmd}; \
#             /usr/local/bin/pdsh -w 10.136.47.[40-41] -l ywjr ${cmd}; \
#             /usr/local/bin/pdsh -w 10.136.130.[161-190] -l dpl ${cmd}`
#        echo "$msg"
#}

GetInfo "$1"
