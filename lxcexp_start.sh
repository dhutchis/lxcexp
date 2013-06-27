#! /bin/sh
# Optional Arguments: the start and end VE number

if [ -z "$1" -o -z "$2" ]
then
    range=`echo /exp/ve* | sed 's/\/exp\///g'` 
else
    range=`seq $1 $2 | sed 's/^/ve/'`
fi

for i in $range
do
    lxc-start -d -n $i -f /exp/$i/config
    sleep 0.05
done



