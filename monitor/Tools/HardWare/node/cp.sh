#!/bin/bash
/usr/local/bin/pdcp -w 10.136.65.[16-51] TouchTest4conf.sh ~/check_hardware/
/usr/local/bin/pdcp -w 10.136.64.[28-45] TouchTest4conf.sh ~/check_hardware/
/usr/local/bin/pdcp -w 10.136.16.[26-47] -l jr TouchTest4conf.sh /home/jr/check_hardware
/usr/local/bin/pdcp -w 10.136.16.[21-25] -l swbjr TouchTest4conf.sh /home/swbjr/check_hardware
/usr/local/bin/pdcp -w 10.136.16.[16-20] -l twbjr TouchTest4conf.sh /home/twbjr/check_hardware
scp TouchTest4conf.sh jr@10.136.16.28:/home/jr/check_hardware
scp TouchTest4conf.sh ywjr@10.136.47.40:/home/ywjr/check_hardware
scp TouchTest4conf.sh ywjr@10.136.47.41:/home/ywjr/check_hardware
scp TouchTest4conf.sh dpl@10.136.130.178:/home/dpl/check_hardware


/usr/local/bin/pdcp -w 10.136.130.[161-190] -l dpl TouchTest4conf.sh /home/dpl/check_hardware
