#! /bin/sh

echo "network setup debug arguments received:" $*
ovs-vsctl add-port brve $5 tag=1

