#/bin/sh

check_address="192.168.1.1"

succ_count=`ping -c5 -W1 $check_address|grep received|awk -F' ' '{print $4}'`

power_status='on'
if [ $succ_count -lt 5 ]; then
	echo "power down"
	power_status='off'
	#power off server
	/tmp/mnt/sda1/MGMT/synctool/offServer.sh 'Power Down' >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1

fi

