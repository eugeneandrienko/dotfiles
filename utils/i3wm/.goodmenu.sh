#!/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #00dd00 -sf #000000 -nb #000000 -nf #00dd00'
DMENU_CMD="dmenu -p 'Execute:' -l 5 -i -b -fn $FONT $COLORS"
DMENU_ITEMS="chrome:keepassx:gimp:enable touchpad:disable touchpad"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD) in
    'chrome')
        google-chrome-stable &
        ;;
    'keepassx')
        keepassx &
        ;;
    'gimp')
        gimp &
        ;;
    'enable touchpad')
        synclient TouchpadOff=0
        ;;
    'disable touchpad')
        synclient TouchpadOff=1
        ;;
    *)
        exit 1
        ;;
esac

