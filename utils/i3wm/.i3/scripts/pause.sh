#!/usr/bin/env bash

# Based on the https://github.com/vermaden/scripts/blob/master/desktop-pause.sh
# See: https://vermaden.wordpress.com/2018/09/19/freebsd-desktop-part-16-configuration-pause-any-application/

ACTIVE_WIN_PID=$(xdotool getactivewindow getwindowpid)

if [[ -z "$ACTIVE_WIN_PID" ]]; then
    echo "Cannot get PID of active window"
    exit 1
fi

STATE=$(ps -o state "$ACTIVE_WIN_PID" | sed 1d)
NAME=$(xdotool getactivewindow getwindowname)

case "$STATE" in
    [ISR]*)
        SIGNAL=STOP
        dunstify "App paused" "$NAME"
        ;;
    T*)
        SIGNAL=CONT
        dunstify "App unpaused" "$NAME"
        ;;
    *)
        dunstify "Cannot (un)pause app!" "$NAME"
        exit 2
        ;;
esac

kill -"$SIGNAL" "$ACTIVE_WIN_PID"
