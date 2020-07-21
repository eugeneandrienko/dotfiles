#!/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu -p Execute: -i -b -fn $FONT $COLORS"

DMENU_ITEMS="firefox:firefox_unsec:telegram:keepassxc"
DMENU_ITEMS+=":audacious:idea:gimp:openshot:simple_scan"
DMENU_ITEMS+=":android-file-transfer:qmapshack"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD) in
    'firefox')
        /usr/bin/apulse /usr/bin/firefox-bin &
        ;;
    'firefox_unsec')
        /usr/bin/apulse /usr/bin/firefox-bin -P unsecure &
        ;;
    'telegram')
        /home/drag0n/telegram/Telegram &
        ;;
    'keepassxc')
        /usr/bin/keepassxc &
        ;;
    'audacious')
        /usr/bin/audacious &
        ;;
    'idea')
        /home/drag0n/idea/bin/idea.sh
        ;;
    'gimp')
        /usr/bin/gimp &
        ;;
    'openshot')
        /usr/bin/openshot-qt &
        ;;
    'simple_scan')
        /usr/bin/simple-scan &
        ;;
    'android-file-transfer')
        /usr/bin/android-file-transfer &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/bin/qmapshack &
        ;;
    *)
        exit 1
        ;;
esac
