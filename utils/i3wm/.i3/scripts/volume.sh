#!/usr/bin/env bash

if [ "$1" = "up" ]; then
    amixer -c 0 -- sset Master 1+
elif [ "$1" = "down" ]; then
    amixer -c 0 -- sset Master 1-
fi

VOLUME=$(amixer -M -c 0 -- get Master | grep 'Mono: Playback' | sed -r 's/.*\[([0-9]+)%\].*/\1/g')
dunstify -h string:x-dunst-stack-tag:audio -h int:value:"$VOLUME" -t 1200 "Volume:"

