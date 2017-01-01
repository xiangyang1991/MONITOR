#!/bin/bash
for j in `seq 1 7`
do
	for i in  `seq 31 36`
	do



		echo -e " $j\t$i"
		echo -e "\e[${j};${i}m $j\t$i\e[0m"
		echo -e "\n"
	done
done
