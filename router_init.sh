#!/bin/sh

#This script is used for init router after booted and external disk mounted.

#Setting up PATH
export PATH=$PATH:/opt/local/bin

#Setting up git env var
export GIT_SSH_COMMAND="/opt/bin/ssh -i ~/.ssh/id_rsa_git"

#Setting up root user home
rm -rf /tmp/home/root && ln -s /tmp/mnt/sda1/admin /tmp/home/root

#use the way below to add cron job
cru a ScheduleSyncfile 	"0 4 * * * 	/tmp/mnt/sda1/MGMT/scripts/autosync.sh "
cru a GoogleHostsUpdate	"1 6 * * * 	/tmp/mnt/sda1/MGMT/scripts/google_hosts.sh >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1"
cru a PowerOnGen8 	"0 19 * * 5 	/tmp/mnt/sda1/MGMT/scripts/bootServer.sh"
cru a PowerOffGen8 	"0 1 * * 1 	/tmp/mnt/sda1/MGMT/scripts/offServer.sh" 
cru a UpdateAliyunDDNS 	"*/3 * * * * 	/tmp/mnt/sda1/MGMT/scripts/ddns-start"
cru a PowerCheck	"*/3 * * * * 	/tmp/mnt/sda1/MGMT/scripts/power_checker.sh"
cru a DiskUsageCheck	"0 * * * * 	/tmp/mnt/sda1/MGMT/scripts/disk_usage_checker.sh"
cru a StatusCheck	"*/2 * * * * 	/tmp/mnt/sda1/MGMT/scripts/status_checker.sh"

#set alias
[ `which vim`X != X ] && alias vi=vim
#

#set aliyun ddns for ssh.shikun.win
/tmp/mnt/sda1/MGMT/scripts/ddns-start


#Setting dnsmasq to support google hosts 
mkdir -p /etc/hosts.d
echo "addn-hosts=/etc/hosts.d/hosts.dnsmasq" >> /jffs/configs/dnsmasq.conf.add


#Setting Firewall
iptables -I INPUT -p tcp --dport 1443 -j ACCEPT
