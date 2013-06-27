#! /bin/sh
# Optional Arguments: the start and end VE number

if [ -z "$1" -o -z "$2" ]
then
    range=`echo /exp/ve* | sed 's/\/exp\///g'` 
else
    range=`seq $1 $2 | sed 's/^/ve/'`
fi

count=0
for i in $range
do
    exp=`lxc-info -p -n $i`
    if [ ! -z "$exp" ]
    then
	count=$((count + 1))
    fi
done
echo $count VEs have a PID
