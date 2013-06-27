#! /bin/sh

cp lxc-ubuntu-v0 /usr/share/lxc/templates/
mkdir /tmp/lxcexp
lxc-create -n ve0 -t ubuntu-v0 -P /tmp/lxcexp
cp lxcexp.conf /var/lib/lxc/ve0/rootfs/etc/init/
cp veconfig /var/lib/lxc/ve0/config
