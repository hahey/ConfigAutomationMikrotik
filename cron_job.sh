#!/bin/bash
# Copyright (C) 2020 Heuna Kim <heynaheyna9@gmail.com>
# Licensed under GPL v3

if [[ $# -lt 4 ]]; then
    echo "USAGE: $(basename "$0") TEMPLATE DEVICE_ID FIRST_THREE_OCTET LAST_OCTET [LAST_OCTET ..]" >&2
    exit 1
fi

for last_octet in "${@:4}"; do
    ssh_target="admin@${3}.${last_octet}"
    ssh-keygen -R "$ssh_target"
    { echo; cat ./scripts/$1 | tr "\n" " "; echo; } | devid=$2 envsubst '$devid' | sshpass -f ./.auth ssh -oStrictHostKeyChecking=no -l admin "${ssh_target}"
    { echo; echo "/system scheduler add name=run-15m interval=15m on-event=ffcron"; echo; } | sshpass -f ./.auth ssh -oStrictHostKeyChecking=no -l admin "${ssh_target}"
    echo "update finished for $ssh_target"
done
