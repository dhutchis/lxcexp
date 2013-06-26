#! /bin/sh

cp lxc-ubuntu-v0 /usr/lib/lxc/templates/
lxc-create -n ve0 -t ubuntu-v0
cp lxcexp.conf /var/lib/lxc/ve0/rootfs/etc/init/
cp veconfig /var/lib/lxc/ve0/config
