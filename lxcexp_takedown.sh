#! /bin/sh
for i in `ls /exp`
do
    lxc-destroy -f -n $i -P /exp
done
umount /exp
rmdir /exp

