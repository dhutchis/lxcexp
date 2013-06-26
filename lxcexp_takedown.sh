#! /bin/sh
for i in `ls /exp`
do
    lxc-kill -n $i
    lxc-destroy -f -n $i -P /exp
done
umount /exp
rmdir /exp

