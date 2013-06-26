#! /bin/sh
for i in `seq 1 ${1}`
do
    lxc-destroy -f -n ve$i -P /exp
done
umount /exp
rmdir /exp

