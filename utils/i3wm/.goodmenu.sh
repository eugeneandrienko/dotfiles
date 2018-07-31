#!/usr/local/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
COLORS='-sb #000000 -sf #ffffff -nb #ffffff -nf #000000'
DMENU_CMD="dmenu2 -p Execute: -l 5 -i -b -fn $FONT $COLORS"
DMENU_ITEMS="firefox:firefox_unsec:keepassxc:qbittorrent:guitarpro"

case $(echo $DMENU_ITEMS | tr ':' '\n' | $DMENU_CMD) in
    'firefox')
        /usr/local/bin/firefox &
        ;;
    'firefox_unsec')
        /usr/local/bin/firefox -P unsecure &
        ;;
    'keepassxc')
        /usr/local/bin/keepassxc &
        ;;
    'qbittorrent')
        /usr/local/bin/qbittorrent &
        ;;
    'guitarpro')
        wine /home/drag0n/.wine/drive_c/Program\ Files/Arobas\ Music/Guitar\ Pro\ 7/GuitarPro7.exe &
        ;;
    *)
        exit 1
        ;;
esac

