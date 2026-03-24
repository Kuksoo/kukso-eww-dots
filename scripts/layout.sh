#!/bin/bash
handle() {
  hyprctl devices -j | jq -r '.keyboards[] | select(.main == true).active_keymap' | cut -c1-2 | tr '[:upper:]' '[:lower:]'
}

handle # Начальное значение
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  case $line in activelayout*) handle ;; esac
done
