#!/bin/sh

#This script is used for init router after booted and external disk mounted.

#Setting up PATH
export PATH=$PATH:/opt/local/bin

#Setting up root user home
rm -rf /tmp/home/root && ln -s /tmp/mnt/sda1/admin /tmp/home/root

#use the way below to add cron job
cru a ScheduleSyncfile "0 4 * * * /tmp/mnt/sda1/MGMT/synctool/autosync.sh >> /tmp/mnt/sda1/MGMT/synctool/log/dvrsync.log 2>&1"

#set alias
[ `which vim`X != X ] && alias vi=vim
#
