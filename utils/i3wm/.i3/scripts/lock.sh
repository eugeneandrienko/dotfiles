#!/usr/bin/env zsh

SCROT=/tmp/i3lock.png

rm -f "$SCROT" /tmp/i3lock_*.png
scrot -moipz -F "$SCROT"
convert "$SCROT" -scale 10% -scale 1000% "$SCROT"
i3lock -fe -c 000000 -i "$SCROT"
sleep 5
xset dpms force off
rm -f "$SCROT" /tmp/i3lock_*.png

