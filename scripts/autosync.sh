#!/bin/sh


scripts_path=$(dirname $0)
. $scripts_path/common/_log


export PATH=/opt/bin:/opt/local/bin:$PATH
GEN8ServerIP="10.0.0.3"
src="/tmp/mnt/sda2/Monitor/HN1A005FAT10058"
dst="root@10.0.0.5:/volume1/MediaStore/LocalStorage/Records/LroomDV/"

sync
current_state=$(ping $GEN8ServerIP -c1 -W1 > /dev/null ; echo $? )
current_state_title=`[ $current_state -eq 0 ] && echo "ON" || echo OFF`

log "Gen8 current state: $current_state_title"



[ $current_state -ne 0 ] && /tmp/mnt/sda1/MGMT/scripts/bootServer.sh && sleep 120

#sleep 120
log "`date +"%Y%m%d%H%M%S"`:running lroom records rsync..."
#cp /tmp/mnt/sda2/Monitor/id_dropbear /tmp/home/root/.ssh
#log "Sync content: $(rsync -zarv --include="*/" --include="*.mp4" --exclude="*" -e "ssh -y" $src  $dst --rsync-path=/bin/rsync )"
log "Sync content: $(rsync -zarv --rsync-path=/bin/rsync --include="*/" --include="*.mp4" --exclude="*" $src  $dst )"
log "`date +"%Y%m%d%H%M%S"`:rsync lroom records finished."

[ $current_state -ne 0 ] && /tmp/mnt/sda1/MGMT/scripts/offServer.sh
