#! /bin/sh
# arg1 is the number of VMs to create
if [ "$1" -gt 65024 ]
then
    echo "Warning: too many VEs to assign IPs; need to use third byte"
    return
fi

mkdir /exp
mount -o size=2G -t tmpfs expm /exp
lxc-clone -o ve0 -n vbase -P /exp        # full copy base ve filesystem to tmpfs
cp /var/lib/lxc/ve0/config.network.sh /exp/vbase/
for i in `seq 1 ${1}`
do
    lxc-clone -B overlayfs -s -o vbase -p /exp -n ve$i -P /exp
    cp /var/lib/lxc/ve0/config.network.sh /exp/ve$i/
    cd=$(( $i / 255 ))
    cm=$(( $i % 255 ))
    echo "lxc.network.ipv4 = 10.0.$cd.$cm" >> /exp/ve$i/config
done

ovs-vsctl add-br brve

