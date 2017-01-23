#!/bin/sh

#This script is used for init router after booted and external disk mounted.

#Setting up PATH
export PATH=$PATH:/opt/local/bin

#Setting up root user home
rm -rf /tmp/home/root && ln -s /tmp/mnt/sda1/admin /tmp/home/root

#use the way below to add cron job
cru a ScheduleSyncfile "0 4 * * * /tmp/mnt/sda1/MGMT/synctool/autosync.sh >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1"
cru a PowerOnGen8 "0 19 * * 5 /tmp/mnt/sda1/MGMT/synctool/bootServer.sh >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1"
cru a PowerOffGen8 "0 1 * * 1 /tmp/mnt/sda1/MGMT/synctool/offServer.sh >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1"
cru a UpdateAliyunDDNS "*/10 * * * * /jffs/scripts/ddns-start >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1"

#set alias
[ `which vim`X != X ] && alias vi=vim
#

#set aliyun ddns for ssh.shikun.win
DDNS_CONFIG_FILE="$HOME/.ddns_config/aliyun_config"
accessKeyID=`grep "accessKeyId" $DDNS_CONFIG_FILE|sed 's/.*=\ //g'`
accessKeySecret=`grep "accessKeySecret" $DDNS_CONFIG_FILE|sed 's/.*=\ //g'`
recordID='89863902'
RR='ssh'
IP=`ip addr show ppp0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1`
CURRENT_RESOLVED_IP=`nslookup ssh.shikun.win 223.5.5.5|tail -n 2|grep Address|awk -F": " '{print $2}'`

if [ X"$IP" == X"$CURRENT_RESOLVED_IP" ]
then
	echo "ssh.shikun.win is up-to-date, not updated it."
	/sbin/ddns_custom_updated 0
	exit
fi

echo "$IP $accessKeyID $accessKeySecret $recordID $RR"
/mnt/sda1/MGMT/ddns/aliyun_ddns.py $IP $accessKeyID $accessKeySecret $recordID $RR

/sbin/ddns_custom_updated 



#Setting Thunder
#cd /tmp/mnt/sda1/MGMT/Thunder && ./portal
