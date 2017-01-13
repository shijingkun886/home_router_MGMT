#!/bin/sh
export PATH=$PATH:/opt/local/bin
GEN8ServerIP="10.0.0.2"
PLAYBOOK_HOME="/mnt/sda1/MGMT/synctool"


#date +"%Y%m%d%H%M%S" 

#power off.
	echo "shutdonn DSM Server......"
	#cp /tmp/mnt/sda2/Monitor/MGMT/id_rsa /tmp/home/root/.ssh
	cd $PLAYBOOK_HOME
	PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_dsm.yml
	sleep 60
	echo "shutdown Gen8 Server......"
	PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_gen8.yml