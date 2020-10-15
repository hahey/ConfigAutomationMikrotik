#/usr/env bash

if [[ $# -lt 3 ]]; then
    echo "USAGE: $(basename "$0") STREET FLOOR TEMPLATE" >&2
    exit 1
fi

ssidlist=(`sudo iwlist wlp1s0 scan| fgrep 'ESSID:"MikroTik' | grep -o '".*"'`)
i=0
for ssid in "${ssidlist[@]}"; do
    i=$((i+1))
    nmcli device wifi connect "${ssid}"
    ssh_target=`ip r|grep -oP "via .* dev"|grep -oe '\([0-9.]*\)'`
    street=$1 floor=$2 idnum=$i envsubst '$street,$floor,$idnum' < "$3" | ssh admin@"${ssh_target}"
    ssh admin@"${ssh_target}" <<<$'XXXXXXXXXXXXXXXX\n/system script run ffconfig'
done
