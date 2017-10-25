#/bin/sh

gen8_address="10.0.0.2"

succ_count=`ping -c5 -W1 $check_address|grep received|awk -F' ' '{print $4}'`

last_power_status=''

if [ $succ_count -lt 5 ]; then
	echo "gen8 is power off"
	power_status='off'
fi

#if status changed, send notify to owner
#plan to use https://sc.ftqq.com/3.version for mesage push
