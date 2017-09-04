#!/bin/sh
date +"%Y%m%d%H%M%S" >> /tmp/mnt/sda2/Monitor/synclog
sync
sleep 3
cp /tmp/mnt/sda2/Monitor/id_dropbear /tmp/home/root/.ssh
#rsync -arzv --include="*.mp4" --exclude="*" -e "ssh -y" /tmp/mnt/sda2/Monitor/HN1A005G8R00087  root@10.0.0.5:/volume1/LocalStore/NAS_STORAGE/Records/LroomDV --rsync-path=/usr/syno/bin/rsync >> /tmp/mnt/sda2/Monitor/synclog 2>&1
rsync -zarv --include="*/" --include="*.mp4" --exclude="*" -e "ssh -y" /tmp/mnt/sda2/Monitor/HN1A005FAT10058 root@10.0.0.5:/volume1/MediaStore/LocalStorage/Records/LroomDV/ --rsync-path=/usr/syno/bin/rsync >> /tmp/mnt/sda2/Monitor/synclog 2>&1
