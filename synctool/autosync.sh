#!/bin/sh
export PATH=$PATH:/opt/local/bin
GEN8ServerIP="10.0.0.2"
logfile="/tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log"


#initialize
echo "`date +"%Y%m%d%H%M%S"`:Begin to sync..."
sync
current_state=`ping $GEN8ServerIP -c1 -W1 > /dev/null ; echo $?`
current_state_title=`[ $current_state -eq 0 ] && echo "ON" || echo OFF`
echo "Gen8 current state: $current_state_title"



#if Gen8 server is power off, power on it.
if [ $current_state -ne 0 ]; then 
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
		state=`ping $GEN8ServerIP -c1 -W1 > /dev/null ; echo $?`
		[ $state == 0 ] && echo "boot successfully." && t=300
		sleep 1
	done
	echo "finish boot time:`date`"
fi

#waiting for DSM boot
sleep 60



########SYNC LROOM DV Records##########
echo $PATH
ls -la ~/.ssh/
src="/tmp/mnt/sda2/Monitor/HN1A005G8R00087"
dst="root@10.0.0.5:/volume1/LocalStore/NAS_STORAGE/Records/LroomDV"
echo "`date +"%Y%m%d%H%M%S"`:running lroom records rsync..."
cp /tmp/mnt/sda2/Monitor/id_dropbear /tmp/home/root/.ssh
rsync -zarv --include="*/" --include="*.mp4" --exclude="*" -e "ssh -y" $src  $dst --rsync-path=/usr/syno/bin/rsync 
echo "`date +"%Y%m%d%H%M%S"`:rsync lroom records finished."



#########SYNC Thunder Download File###########

src=""
dst=""



#if Gen8 server is power off original, poweroff it.
if [ $current_state -ne 0 ]; then 
	echo "shutdonn DSM Server......"
	cp /tmp/mnt/sda2/Monitor/MGMT/id_rsa /tmp/home/root/.ssh
	cd /mnt/sda1/MGMT/synctool
	PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_dsm.yml
	sleep 60
	echo "shutdown Gen8 Server......"
	PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_gen8.yml
fi

