#/bin/sh

check_address="192.168.1.1"

succ_count=`ping -c5 -W1 $check_address|grep received|awk -F' ' '{print $4}'`
if [ $succ_count -lt 5 ]; then
	echo "sleep 60s, check again"
	sleep 60
        succ_count=`ping -c5 -W1 $check_address|grep received|awk -F' ' '{print $4}'`
fi

power_status='on'
if [ $succ_count -lt 5 ]; then
	echo "home power outage"
	power_status='off'
	#power off server
	/tmp/mnt/sda1/MGMT/synctool/offServer.sh 'Home Power Outage' >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1

fi

