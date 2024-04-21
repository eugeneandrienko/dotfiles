#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

if [ "$MACHINE_HW" = "zalman" ]; then
    amixer -c 0 -- sset Master toggle 1>/dev/null 2>&1
elif [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    mixer vol.mute=^ 1>/dev/null 2>&1
fi
