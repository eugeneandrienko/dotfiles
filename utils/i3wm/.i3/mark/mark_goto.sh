#!/usr/bin/env zsh

DMENU_CMD="rofi -dmenu -sep ':' -p 'Goto mark'"

LIST_OF_MARKS=$(i3-msg -t get_marks | jq '.[]' | tr -d '"' | tr '\n' ':' | sed -r 's/(.*):$/\1/g')
MARK=$(echo "$LIST_OF_MARKS" | eval "$DMENU_CMD")
if [ -n "$MARK" ]; then
    i3-msg "[con_mark=\"$MARK\"] focus"
fi
