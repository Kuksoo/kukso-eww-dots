#!/bin/bash
generate() {
  active=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .activeWorkspace.id')
  seq 1 10 | jq -nc --arg active "$active" '[range(1;11) | {id: ., active: (. == ($active|tonumber))}]'
}
generate
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  case $line in workspace*) generate ;; esac
done
