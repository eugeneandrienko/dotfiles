#!/usr/bin/env zsh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

MODES_ITEMS="normal:theatre:night:redshift:noredshift"
case $(echo $MODES_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Mode:") in
    'normal')
        xset +dpms
        ;;
    'theatre')
        xset -dpms
        ;;
    'night')
        ;;
    'redshift')
        ~/.bin/redshift.sh
        ;;
    'noredshift')
        pkill redshift
        ;;
    *)
        exit 2
        ;;
esac

