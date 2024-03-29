#! /bin/sh

echo Disk Usage of VEs: `du -ch /exp | tail -n 2 | head -n 1`
ve_total=`echo /exp/ve* | tr ' ' '\n' | wc -l`                # total # of VEs
wclines=`wc -l /exp/ve*/delta0/home/ubuntu/log_ping | head -n -1 | tr -d ' ' | cut -f 1 -d '/' `
ve_success=`echo $wclines | tr ' ' '\n' | grep 188 | wc -l`   # VEs outputting 188 lines to log_ping
ve_somelines=`echo $wclines | tr ' ' '\n' | wc -l`            # VEs outputting at least one line to log_ping
ve_incomplete=`expr ${ve_somelines} - ${ve_success}`          # VEs outputting < 188 lines to log_ping
ve_failed=`expr ${ve_total} - ${ve_somelines}`                # VEs failed to create log_ping
echo "Total VE direcs  :" ${ve_total}
echo "180-ping VEs     :" ${ve_success}
echo "Incomplete VEs   :" ${ve_incomplete}
echo "No log file VEs  :" ${ve_failed}
./lxcexp_running.sh

