#! /bin/sh
for i in `echo /exp/ve* | sed 's/\/exp\///g'`
do
    lxc-kill -n $i
    lxc-destroy -f -n $i -P /exp
done
lxc-kill -n vbase
lxc-destroy -f -n vbase -P /exp
umount /exp
rmdir /exp
ovs-vsctl del-br brve
