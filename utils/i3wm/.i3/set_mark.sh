#!/usr/bin/env bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

LIST_OF_MARKS='ff:fp:k:t'
MARK="$(echo $LIST_OF_MARKS | tr ':' '\n' | $DMENU_CMD -p 'Set mark:')"
if [ -n "$MARK" ]; then
    i3-msg "mark --toggle $MARK"
fi

