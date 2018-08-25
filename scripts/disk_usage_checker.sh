#/bin/sh

free_space=$(df -m /dev/sda2|tail -n 1|awk '{print $4}')


if [ $free_space -lt 10000 ]; then
	disk_usage=$(df -h)
	$(dirname $0)/send_notify.sh "R7000磁盘使用告警 " "$disk_usage"
	echo "$disk_usage"
fi


