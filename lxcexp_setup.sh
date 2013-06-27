#! /bin/sh
# arg1 is the number of VMs to create
mkdir /exp
mount -o size=2G -t tmpfs expm /exp
lxc-clone -o ve0 -n vbase -P /exp        # full copy base ve filesystem to tmpfs
for i in `seq 1 ${1}`
do
    lxc-clone -B overlayfs -s -o vbase -p /exp -n ve$i -P /exp
done

