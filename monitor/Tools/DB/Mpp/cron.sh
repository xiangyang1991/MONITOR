#!/bin/bash
. /etc/profile
. ~/.bash_profile
/home/ycl/monitor/Tools/DB/Mpp/data2mpp.sh `date -d "1 days ago" +%Y-%m-%d` recount
