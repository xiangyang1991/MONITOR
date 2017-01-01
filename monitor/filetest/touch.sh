#!/bin/bash
limit=50
TouchFile(){
	for i in `seq $1 $2`; do
		{
			head -n 500 /dev/urandom | sed 's/[^a-Z0-9]//g' | strings -n 4 > $i.file 
		} &
		while :
		do
			count=`ps -ef | grep "$$" | awk '{print $2}' | wc -l`
			if [ $limit -lt $count ]; then
				:
			else
				break
			fi
		done
	done
}
{
	TouchFile 1 2000;
} &
{
	TouchFile 2001 4000;
} &
{
	TouchFile 4001 6000;
} &
{
	TouchFile 6001 8000;
} &
{
	TouchFile 8001 10000;
} &
{
	TouchFile 10001 12000;
} &
{
	TouchFile 12001 14000;
} &
{
	TouchFile 14001 16000;
} &
{
	TouchFile 16001 18000;
} &
{
	TouchFile 18001 20000;
} &
wait
