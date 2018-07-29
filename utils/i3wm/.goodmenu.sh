#!/usr/local/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu2 -p Execute: -l 5 -i -b -fn $FONT $COLORS"
DMENU_ITEMS="firefox:keepassxc"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD) in
    'firefox')
        /usr/local/bin/firefox &
        ;;
    'keepassxc')
        /usr/local/bin/keepassxc &
        ;;
    *)
        exit 1
        ;;
esac

