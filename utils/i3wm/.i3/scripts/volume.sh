#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

if [ "$MACHINE_HW" = "zalman" ]; then
    if [ "$BLOCK_BUTTON" -eq 1 ]; then
        ~/.i3/scripts/mute.sh
    elif [ "$1" = "up" ]; then
        amixer -c 0 -- sset Master 1+
    elif [ "$1" = "down" ]; then
        amixer -c 0 -- sset Master 1-
    fi
    VOLUME=$(amixer -M -c 0 -- get Master | grep 'Mono: Playback' | sed -r 's/.*\[([0-9]+)%\].*/\1/g')
elif [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    if [ "$BLOCK_BUTTON" -eq 1 ]; then
        ~/.i3/scripts/mute.sh
    elif [ "$1" = "up" ]; then
        mixer vol.volume=+0.05:+0.05
    elif [ "$1" = "down" ]; then
        mixer vol.volume=-0.05:-0.05
    fi
    VOLUME=$(mixer -o vol.volume | sed -r 's/.*=([0-9.]+):.*/\1/g')
    VOLUME=$(echo "$VOLUME * 100" | bc)
fi

if [ "$1" = "get" ]; then
    VOLUME=$(echo "$VOLUME/1" | bc)
    if [ "$MACHINE_HW" = "zalman" ] && $(amixer -M -c 0 -- get Master | grep 'Mono:' | grep -q '\[off\]'); then
        echo "🔇"
    elif [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ] && \
             $(mixer vol.mute | grep -q =on); then
        echo "🔇"
    else
        echo "🔊$VOLUME%"
    fi
else
    dunstify -h string:x-dunst-stack-tag:audio -h int:value:"$VOLUME" -t 1200 "Volume:"
fi
