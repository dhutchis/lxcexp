#! /bin/sh

cp lxc-ubuntu-v0 /usr/share/lxc/templates/
mkdir /tmp/lxcexp
lxc-create -n ve0 -t ubuntu-v0
cp lxcexp.conf /var/lib/lxc/ve0/rootfs/etc/init/
cp veconfig /var/lib/lxc/ve0/config
cp config.network.sh /var/lib/lxc/ve0/
# remove with lxc-destroy -n ve0
