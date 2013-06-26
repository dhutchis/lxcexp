#! /bin/sh
for i in `ls /exp`
do
    lxc-info --name $i
    if [ -e /exp/$i/delta0/home/ubuntu/log_ping ]
    then 
	echo $i has `wc -l /exp/$i/delta0/home/ubuntu/log_ping | cut -f 1 -d \ ` lines in log_ping
    fi
done
