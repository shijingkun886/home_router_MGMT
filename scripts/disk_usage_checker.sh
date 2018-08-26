#/bin/sh -e

. $(dirname $0)/common/_log
. $(dirname $0)/common/_notify

# Free space and threshold's unit is MB
free_space=$(df -m /dev/sda2|tail -n 1|awk '{print $4}')


threshold=10000


if [ $free_space -lt $threshold ]; then
	disk_usage=$(df -h)
	send_notify "R7000磁盘使用告警 " "$disk_usage"
	echo "$disk_usage"
fi


