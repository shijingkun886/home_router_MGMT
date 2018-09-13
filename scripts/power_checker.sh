#/bin/sh -eu


. $(dirname $0)/common/_log
. $(dirname $0)/common/_notify


check_address="192.168.1.1"

succ_count=`ping -c5 -W1 $check_address|grep received|awk -F' ' '{print $4}'`
if [ $succ_count -lt 4 ]; then
	log "power check 1st step failed, sleep 30s, check again"
	sleep 30
        succ_count=`ping -c5 -W1 $check_address|grep received|awk -F' ' '{print $4}'`
fi

power_status='on'
if [ $succ_count -lt 4 ]; then
	log "home power outage"
	send_notify "PowerCheck" "home power outage"
	$(dirname $0)/offServer.sh
fi
echo 'Power Supply fine'
