#! /bin/sh
for i in `seq 1 ${1}`
do
    lxc-info --name ve$i
    if [ -e /exp/ve$i/delta0/home/ubuntu/log_ping ]
    then 
	echo ve$i has `wc -l /exp/ve$i/delta0/home/ubuntu/log_ping | cut -f 1 -d \ ` lines in log_ping
    fi
done
