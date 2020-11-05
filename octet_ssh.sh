#/usr/env bash
# Copyright (C) 2020 Heuna Kim <heynaheyna9@gmail.com>
# Licensed under GPL v3

if [[ $# -lt 4 ]]; then
    echo "USAGE: $(basename "$0") STREET FLOOR TEMPLATE LAST_OCTET [LAST_OCTET ..]" >&2
    exit 1
fi

for last_octet in "${@:4}"; do
    ssh_target="admin@10.31.68.${last_octet}"
    { echo; cat ./scripts/$3 | tr "\n" " "; echo; } | sshpass -f ./.auth "${ssh_target}"
    ssh "${ssh_target}" <<<'/system script run ffconfig'
done
