#! /bin/sh
for i in `seq 1 ${1}`
do
    lxc-start -d -n ve$i -f /exp/ve$i/config
done

