#!/bin/sh
export PATH=$PATH:/opt/local/bin
GEN8ServerIP="10.0.0.2"
PLAYBOOK_HOME="/mnt/sda1/MGMT/synctool"
OFF_REASON="Manual Poweroff"
echo $1
if [ "$1"a != "a" ]; then
	echo Reason: $1
	OFF_REASON=$1
fi

echo `date +"%Y-%m-%d %H:%M:%S"`, $OFF_REASON >> /tmp/mnt/sda1/MGMT/synctool/log/gen8_off_history.log
#date +"%Y%m%d%H%M%S" 

#power off.
	cd /mnt/sda1/MGMT/synctool
	echo "shutdonn DSM Server......"
	#cp /tmp/mnt/sda2/Monitor/MGMT/id_rsa /tmp/home/root/.ssh
	cd $PLAYBOOK_HOME
	PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_dsm.yml
	PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_win10.yml
	sleep 60
	echo "shutdown Gen8(Esxi Host) Server......"
	PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_gen8.yml
