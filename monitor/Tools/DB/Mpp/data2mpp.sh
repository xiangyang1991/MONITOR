#!/usr/bin/expect
set day [lindex $argv 0]
spawn ssh -t -p 22 mpp2@10.136.139.19 ./mpp-engine/monitor/mpp-count.sh $day
	expect "password:"
	send "liuge1\r"
interact
