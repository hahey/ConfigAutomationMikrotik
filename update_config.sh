#!/bin/bash
# Copyright (C) 2020 Heuna Kim <heynaheyna9@gmail.com>
# Licensed under GPL v3

if [[ $# -lt 3 ]]; then
    echo "USAGE: $(basename "$0") TEMPLATE FIRST_THREE_OCTET LAST_OCTET [LAST_OCTET ..]" >&2
    exit 1
fi

for last_octet in "${@:3}"; do
    ssh_target="admin@${2}.${last_octet}"
    ssh-keygen -R "$ssh_target"
    { echo; cat ./scripts/$1 | tr "\n" " "; echo; } | sshpass -f ./.auth ssh -oStrictHostKeyChecking=no -l admin "${ssh_target}"
    { echo; echo "/system script run ffupdate"; echo; } | sshpass -f ./.auth ssh -oStrictHostKeyChecking=no -l admin "${ssh_target}"
    echo "update finished for $ssh_target"
done
