#!/usr/bin/expect
set day [lindex $argv 0]
spawn ssh dpl@10.136.64.37 "/home/dpl/project/mpp-bdap-loader/bin/checktotal.sh $day; cat /home/dpl/.tmpwb"
        expect "password:"
        send "dpl\r"
interact
