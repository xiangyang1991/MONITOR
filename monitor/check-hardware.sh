#!/bin/bash
. /etc/profile 2>/dev/null
. ~/.bash_profile
. ${MONITOR_ENV}/.ENV_FILE
#${HardWare}/sys-info.sh
echo -e "${wathet_1_7}----------------------检查内存使用情况-----------------------${end}"
${HardWare}/check-mem.sh $1
echo -e "${wathet_1_7}---------------------检查系统盘使用情况----------------------${end}"
${HardWare}/check-disk-free.sh $1
echo -e "${wathet_1_7}---------------------检查系统盘可写状态----------------------${end}"
${HardWare}/check-disk-available.sh $1
