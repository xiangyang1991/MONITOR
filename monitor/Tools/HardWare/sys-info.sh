#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE

msg=`GetInfo "date +%Y-%m-%d\ %H:%M:%S"`
echo "$msg"
msg=`GetInfo "uptime"`
echo "$msg"
