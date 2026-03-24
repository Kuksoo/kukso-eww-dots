#!/bin/bash
handle() {
  # Проверяем, есть ли хоть одно полноэкранное окно на текущем мониторе
  is_fs=$(hyprctl monitors -j | jq '.[] | select(.focused == true) | .activeWorkspace.fullscreen')
  if [ "$is_fs" = "true" ]; then
    echo "true"
  else
    echo "false"
  fi
}

handle
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  case $line in fullscreen*) handle ;; esac
done
