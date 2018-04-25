#!/bin/sh
echo "setup vlan by command: robocfg vlans reset vlan 2 ports "0u 1t 2t 3t 5u" vlan 1 ports "0t 1u 2u 3u 4u 5t" vlan 43 ports "0t 1t 2t 3t""
robocfg vlans reset vlan 2 ports "0u 1t 2t 3t 5u" vlan 1 ports "0t 1u 2u 3u 4u 5t" vlan 43 ports "0t 1t 2t 3t"
