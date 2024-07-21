#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

SCROT=/tmp/i3lock.png

rm -f "$SCROT" /tmp/i3lock_*.png
scrot -moipz -F "$SCROT"
convert "$SCROT" -scale 10% -scale 1000% "$SCROT"
i3lock -fe -c 000000 -i "$SCROT"
sleep 5
if [ "$MACHINE_HW" != "thinkpad" ]; then
    xset dpms force off
fi
rm -f "$SCROT" /tmp/i3lock_*.png

