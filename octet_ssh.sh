#/usr/env bash

if [[ $# -lt 4 ]]; then
    echo "USAGE: $(basename "$0") STREET FLOOR TEMPLATE LAST_OCTET [LAST_OCTET ..]" >&2
    exit 1
fi

i=0
for last_octet in "${@:4}"; do
    i=$((i+1))
    ssh_target="admin@10.31.69.${last_octet}"
    street=$1 floor=$2 idnum=$i envsubst '$street,$floor,$idnum' < "$3" | ssh "${ssh_target}"
    ssh "${ssh_target}" <<<'/system script run ffconfig'
done
