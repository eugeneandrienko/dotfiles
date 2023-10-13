#!/usr/bin/env zsh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#46585e' -sf '#fdf6e3' -nb '#fdf6e3' -nf '#46585e'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

LIST_OF_MARKS='ff:fp:k:t'
MARK=$(echo $LIST_OF_MARKS | tr ':' '\n' | eval "$DMENU_CMD -p 'Set mark:'")
if [ -n "$MARK" ]; then
    i3-msg "mark --toggle $MARK"
fi

