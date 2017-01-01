#!/bin/bash
msg=`/usr/local/bin/pdsh -w 10.136.65.[16-51] "~/TouchTest.sh 2>&1"`
echo "$msg"
msg=`/usr/local/bin/pdsh -w 10.136.65.[16-51] "~/TouchTest.sh 2>&1" 2>&1`
