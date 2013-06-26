#! /bin/sh
# arg1 is the number of VMs to create
mkdir /exp
mount -o size=2G -t tmpfs expm /exp
for i in `seq 1 ${1}`
do
    lxc-clone -B overlayfs -s -o ve0 -n ve$i -P /exp
done

