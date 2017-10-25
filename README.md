# home router MGMT
This is some scripts used for manage the service on the router(asus-merlin) for my home personal


Usage:

add `export PATH=$PATH:/opt/local/bin` to /jffs/configs/profile.add

add `[ -f /mnt/sda1/MGMT/router_init.sh ] && sh /mnt/sda1/MGMT/router_init.sh` to /jffs/scripts/post-mount

add you own iptables rule, like `iptables -I INPUT -p tcp --dport 80 -j ACCEPT` to /jffs/scripts/wan-start
