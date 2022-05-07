#!/usr/bin/env zsh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

MODES_ITEMS="display mode:redshift"
case $(echo $MODES_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Select:") in
    'display mode')
        case $(echo "normal:threatre:night" | tr ':' '\n' | eval "$DMENU_CMD -p '>'") in
            'normal')
                xset +dpms
                ;;
            'theatre')
                xset -dpms
                ;;
            'night')
                ;;
        esac
        ;;
    'redshift')
        case $(echo "on:off" | tr ':' '\n' | eval "$DMENU_CMD -p '>'") in
            'on')
                ~/.bin/redshift.sh
                ;;
            'off')
                pkill redshift
                ;;
        esac
        ;;
    *)
        exit 2
        ;;
esac

