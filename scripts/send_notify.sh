#!/bin/sh

token=$(cat $HOME/.notify_config/token)

title=$(date +"%Y-%m-%d %H:%M:%S")" $1"
msg=$(echo -e '```'"\n$2\n"'```')
#msg=$(echo -e "```\n$2\n```")


curl --data-urlencode text="$title" --data-urlencode desp="$msg" https://sc.ftqq.com/$token.send
