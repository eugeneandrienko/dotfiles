#!/usr/bin/env zsh

DMENU_CMD="rofi -dpi 0 -dmenu -sep ':' -p 'Set mark'"

LIST_OF_MARKS='ff:fp:k:t'
MARK=$(echo $LIST_OF_MARKS | eval "$DMENU_CMD")
if [ -n "$MARK" ]; then
    i3-msg "mark --toggle $MARK"
fi
