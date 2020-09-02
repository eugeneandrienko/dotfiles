#!/usr/bin/env bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

LIST_OF_MARKS=$(i3-msg -t get_marks | jq '.[]' | tr -d '"' | tr '\n' ':' | sed -r 's/(.*):$/\1/g')
MARK="$(echo "$LIST_OF_MARKS" | tr ':' '\n' | $DMENU_CMD -p 'Goto mark:')"
if [ -n "$MARK" ]; then
    i3-msg "[con_mark=\"$MARK\"] focus"
fi

