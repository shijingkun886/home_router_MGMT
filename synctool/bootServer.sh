#!/bin/sh

ServerIP=10.0.0.2


echo "booting Gen8 server......"
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
	[ $state == 0 ] && echo "boot successfully." && t=300
	sleep 1
done
echo "finish boot time:`date`"
[ $state == 0 ] || (echo "boot failed in 300s." && exit 1)
