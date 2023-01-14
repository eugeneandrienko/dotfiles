#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

if [ "$MACHINE_HW" = "zalman" ]; then
    amixer -c 0 -- sset Master toggle 1>/dev/null 2>&1;
elif [ "$MACHINE_HW" = "thinkpad" ]; then
    amixer -c 0 -- sset Master toggle 1>/dev/null 2>&1;
    MASTER_STATE=$(amixer -c 0 -- sget Master | grep 'Mono:' | sed -r 's/.*\[(o[nf]f?)\]/\1/g')
    HEADPHONE_LEVEL=$(amixer -c 0 -- sget Headphone | grep 'Front Left:' | sed -r 's/.*\[([0-9]+)%\].*/\1/g')
    SPEAKER_LEVEL=$(amixer -c 0 -- sget Speaker | grep 'Front Left:' | sed -r 's/.*\[([0-9]+)%\].*/\1/g')
    # Headphone will be muted automatically, if Master already muted:
    if [ "$HEADPHONE_LEVEL" -ne "0" ] && [ "$MASTER_STATE" == "on" ]; then
        amixer -c 0 -- sset Headphone toggle 1>/dev/null 2>&1;
    # Speaker will be muted automatically, if Master already muted:
    elif [ "$SPEAKER_LEVEL" -ne "0" ] && [ "$MASTER_STATE" == "on" ]; then
        amixer -c 0 -- sset Speaker toggle 1>/dev/null 2>&1;
    fi
fi
