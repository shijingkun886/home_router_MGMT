#!/bin/sh

token=$(cat $HOME/.notify_config/token)

title=$1
msg=$2


curl --data-urlencode text="$title" --data-urlencode desp="$msg" https://sc.ftqq.com/$token.send
