#!/bin/sh -e

. $(dirname $0)/common/_log

export PATH=$PATH:/opt/local/bin
GEN8ServerIP="10.0.0.2"
PLAYBOOK_HOME="/mnt/sda1/MGMT/synctool"


#power off.
	cd $(dirname $0)
	log "shutting down VMs"
	#cp /tmp/mnt/sda2/Monitor/MGMT/id_rsa /tmp/home/root/.ssh
	cd $PLAYBOOK_HOME
	log "shutdown dsm result, $(PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_dsm.yml)"
	log "shutdown win10 result, $(PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_win10.yml)"
	sleep 60
	log "shutdown Gen8(Esxi Host) Server......"
	dbus set gen8Status='off'
	log "shutdown Esxi Host result, $(PATH=/opt/bin:$PATH ansible-playbook playbook/shutdown_gen8.yml)"
