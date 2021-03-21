#!/usr/bin/env bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu -p Execute: -i -b -fn $FONT $COLORS"

DMENU_ITEMS="firefox:firefox_unsec:telegram:keepassxc"
DMENU_ITEMS+=":android-file-transfer:qmapshack"
DMENU_ITEMS+=":audacity"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD) in
    'firefox')
        /home/drag0n/.i3/firefox.sh
        ;;
    'firefox_unsec')
        /usr/local/bin/firefox -P unsecure &
        ;;
    'telegram')
        /home/drag0n/bin/telegram/Telegram &
        ;;
    'keepassxc')
        /usr/local/bin/keepassxc &
        ;;
    'android-file-transfer')
        /usr/local/bin/android-file-transfer &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/local/bin/qmapshack &
        ;;
    'audacity')
        /usr/bin/audacity &
        ;;
    *)
        exit 1
        ;;
esac

