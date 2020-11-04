#!/bin/bash

# Copyright (C) 2020 Heuna Kim <heynaheyna9@gmail.com>
# Licensed under GPL v3

# set -e
# set -x

if [[ $# -lt 4 ]]; then
    echo "USAGE: $(basename "$0") STREET FLOOR TEMPLATE PASSWORD" >&2
    exit 1
fi

ssidlist=( $(sudo iwlist wlp1s0 scan| fgrep 'ESSID:"MikroTik' | grep -o '".*"'|uniq| tr "\n" " ") )
echo "${#ssidlist[@]}"
echo "going through the following ssids to connect:"
echo "${ssidlist[@]}"
i=0
for ssidq in "${ssidlist[@]}"; do
    [ -f $HOME/.ssh/known_hosts ] && rm $HOME/.ssh/known_hosts
    i=$((i+1))
    ssid=$(echo $ssidq | tr -d '"')
    nmcli device wifi connect "${ssid}"
    ssh_target=`ip r|grep -oP "via .* dev"|grep -oe '\([0-9.]*\)'`
    echo "floor-idnum $2-${i} : ${ssid}"
    { echo; cat ./scripts/$3 | tr "\n" " "; echo; } | street=$1 floor=$2 passwd=$4 idnum=$i envsubst '$street,$floor,$passwd,$idnum' | ssh -oStrictHostKeyChecking=no -l admin "${ssh_target}"
    ssh -oStrictHostKeyChecking=no -oConnectTimeout=10 -oBatchMode=yes -oServerAliveInterval=10 -l admin "${ssh_target}" '/system script run ffconfig'
done
