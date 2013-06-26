#! /bin/sh
for i in `ls /exp`
do
    lxc-start -d -n $i -f /exp/$i/config
    sleep 0.2
done

