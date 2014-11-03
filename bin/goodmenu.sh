#!/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
DMENU_CMD="dmenu -p 'Execute:' -l 3 -i -b -fn $FONT"
DMENU_ITEMS="chrome:gvim:enable touchpad:disable touchpad"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD) in
    'chrome')
        chrome &
        ;;
    'gvim')
        gvim &
        ;;
    'enable touchpad')
        synclient TouchpadOff=0
        ;;
    'disable_touchpad')
        synclient TouchpadOff=1
        ;;
    *)
        exit 1
        ;;
esac

