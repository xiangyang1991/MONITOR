#!/bin/bash


msg=`impala-shell -i 10.136.130.180:21400 -q \
	"use db; use db;\
	select count(*) from tp_msg_microblog \
	where m_publish_time>=unix_timestamp('2016-12-20 00:00:00') 
	  and m_publish_time<unix_timestamp('2016-12-20 23:59:59') 
	  and g_asp='Weibo';"`
echo "$msg" | grep "|" | grep -v count\(\) | awk -F "|" '{print $2}'
