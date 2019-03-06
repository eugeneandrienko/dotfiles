#!/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu -p Execute: -l 5 -i -b -fn $FONT $COLORS"
DMENU_ITEMS="firefox:firefox_unsec:telegram:keepassxc:qbittorrent:idea:guitarpro:krita:simple_scan:android-file-transfer"

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
    'qbittorrent')
        /usr/bin/qbittorrent &
        ;;
    'idea')
        /home/drag0n/idea/bin/idea.sh
        ;;
    'guitarpro')
        wine /home/drag0n/.wine/drive_c/Program\ Files\ \(x86\)/Arobas\ Music/Guitar\ Pro\ 7/GuitarPro7.exe &
        ;;
    'krita')
        /usr/bin/krita &
        ;;
    'simple_scan')
        /usr/bin/simple-scan &
        ;;
    'android-file-transfer')
        /usr/bin/android-file-transfer &
        ;;
    *)
        exit 1
        ;;
esac

