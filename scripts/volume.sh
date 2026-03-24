#!/bin/bash

get_vol() {
    data=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    if echo "$data" | grep -q "\[MUTED\]"; then
        echo "mute"
    else
        echo "$data" | awk '{print int($2 * 100)}'
    fi
}

get_vol
pactl subscribe | stdbuf -oL grep --line-buffered "sink" | while read -r line; do
    get_vol
done
