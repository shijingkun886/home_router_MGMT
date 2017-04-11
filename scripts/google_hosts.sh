#!/bin/sh
wget -q https://raw.githubusercontent.com/racaljk/hosts/master/hosts -O /etc/hosts.google --no-check-certificate
egrep "^10.|^127." /etc/hosts >> /etc/hosts.google
mv /etc/hosts.google /etc/hosts.d/hosts.dnsmasq
service restart_dnsmasq
