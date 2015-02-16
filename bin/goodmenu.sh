#!/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #9f9f9f -sf #333333'
DMENU_CMD="dmenu -p 'Execute:' -l 5 -i -b -fn $FONT $COLORS"
DMENU_ITEMS="chrome:audacity:gimp:krita:enable touchpad:disable touchpad"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD) in
    'chrome')
        chrome &
        ;;
    'audacity')
        audacity &
        ;;
    'gimp')
        gimp &
        ;;
    'krita')
        krita &
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

