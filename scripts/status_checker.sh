#/bin/sh -e

. $(dirname $0)/common/_log
. $(dirname $0)/common/_notify

gen8_address="10.0.0.3"

succ_count=`ping -c5 -W1 $gen8_address|grep received|awk -F' ' '{print $4}'`

last_power_status=$(dbus get gen8Status)

[ $succ_count -lt 4 ] && current_status='off' || current_status='on'

echo $current_status
echo $last_power_status

if [ x$last_power_status != x$current_status ]; then
  
  [ x$last_power_status == x"off" ] && log "server status inconsistent, may caused by manual power change." && setStatus "on"
  [ x$last_power_status == x"on" ] && log "server status inconsistent, may caused by manual power change, or the power outage" && send_notify "StateChecker" "Server did not shotdown by scripts, please check the power"
fi

