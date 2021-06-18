#!/usr/bin/env bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

DMENU_ITEMS="firefox:firefox_unsec:telegram:keepassxc"
DMENU_ITEMS+=":gimp"
DMENU_ITEMS+=":qmapshack:josm"
DMENU_ITEMS+=":android-file-transfer"
DMENU_ITEMS+=":modes"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD -p Execute:) in
    'firefox')
        /home/drag0n/.i3/firefox.sh
        ;;
    'firefox_unsec')
        /usr/local/bin/firefox -P unsecure &
        ;;
    'telegram')
        /usr/local/bin/telegram-desktop &
        ;;
    'keepassxc')
        /usr/local/bin/keepassxc &
        ;;
    'gimp')
        /usr/local/bin/gimp &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/local/bin/qmapshack &
        ;;
    'josm')
        /usr/local/bin/java -jar /home/drag0n/bin/josm/josm-tested.jar &
        ;;
    'android-file-transfer')
        /usr/local/bin/android-file-transfer &
        ;;
    'modes')
        MODES_ITEMS="normal:theatre:night"
        case $(echo $MODES_ITEMS | tr ':' '\n' | $DMENU_CMD -p Mode:) in
            'normal')
                xset +dpms
                rm -f ~/.mode-theatre
                ;;
            'theatre')
                touch ~/.mode-theatre
                xset -dpms
                ;;
            'night')
                ;;
            *)
                exit 2
                ;;
        esac
        ;;
    *)
        exit 1
        ;;
esac

