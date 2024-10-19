#!/usr/bin/env zsh

FONT="Hack-14"
COLORS="-sb '#46585e' -sf '#fdf6e3' -nb '#fdf6e3' -nf '#46585e'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

LIST_OF_MARKS=$(i3-msg -t get_marks | jq '.[]' | tr -d '"' | tr '\n' ':' | sed -r 's/(.*):$/\1/g')
MARK=$(echo "$LIST_OF_MARKS" | tr ':' '\n' | eval "$DMENU_CMD -p 'Goto mark:'")
if [ -n "$MARK" ]; then
    i3-msg "[con_mark=\"$MARK\"] focus"
fi

