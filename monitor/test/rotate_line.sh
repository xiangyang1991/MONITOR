#!/bin/bash
function rotate_line
{
	INTERVAL=0.15
	TCOUNT=0

	while :; do
		TCOUNT=`expr $TCOUNT + 1`


		case $TCOUNT in
			"1") echo -e '-'"\b\c"
				sleep $INTERVAL
				;;
			"2") echo -e '\\'"\b\c"
				sleep $INTERVAL
				;;
			"3") echo -e "|\b\c"
				sleep $INTERVAL
				;;
			"4") echo -e "/\b\c"
				sleep $INTERVAL
				;;
			*) TCOUNT='0'
				;;
		esac
	done
}
rotate_line &

ROTATE_PID=$!
echo "22222222"
sleep 20
echo "11111111"
kill -9 $ROTATE_PID
#echo -e "\b\b"