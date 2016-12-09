#!/bin/bash
#MONITOR_HOME=$(cd `dirname $0`; pwd)
#ENV="${MONITOR_HOME}/.ENV"
#. ${MONITOR_HOME}/.ENV_FILE
#echo $Load
#The MONITOR_HOME was set in .bash_profile
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
echo ${MONITOR_ENV}
echo ${MONITOR_HOME}
echo -e "${green_1}${Load}${end}"
