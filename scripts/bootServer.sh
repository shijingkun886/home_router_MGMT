#!/bin/sh

. $(dirname $0)/common/_log
. $(dirname $0)/common/_notify

ServerIP=10.0.0.3


log "booting Gen8 server"
echo "begin boot time:`date`"
ether-wake -i br0 1C:98:EC:0F:90:D9
ether-wake -i br0 1C:98:EC:0F:90:D8
ether-wake -i br0 1C:98:EC:0F:90:D9
ether-wake -i br0 1C:98:EC:0F:90:D8
t=0
while [ $t -lt 300 ]; do 
	t=`expr $t + 1`
	[ $t == 1 ] && echo "Time Used:"
	echo -ne "$t "
	state=`ping $ServerIP -c1 -W1 > /dev/null ; echo $?`
	[ $state == 0 ] && log "boot successfully." && t=300
	sleep 1
done
echo "finish boot time:`date`"
[ $state == 0 ] && dbus set gen8Status='on'|| (send_notify "bootServer" "boot failed in 300s." && exit 1)
