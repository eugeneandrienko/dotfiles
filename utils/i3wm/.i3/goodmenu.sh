#!/usr/bin/env zsh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"
echo $DMENU_CMD

if [ -f ~/.gentoo ]; then
    DMENU_ITEMS="firefox:firefox_unsec:telegram:keepassxc"
    DMENU_ITEMS+=":audacious:gimp:openshot:audacity"
    DMENU_ITEMS+=":qmapshack:josm"
    DMENU_ITEMS+=":idea:android-file-transfer"
    DMENU_ITEMS+=":modes"
elif [ -f ~/.freebsd-thinkpad ]; then
    DMENU_ITEMS="firefox:firefox_unsec:telegram:keepassxc"
    DMENU_ITEMS+=":gimp"
    DMENU_ITEMS+=":qmapshack:josm"
    DMENU_ITEMS+=":android-file-transfer"
    DMENU_ITEMS+=":modes"
fi

case $(echo $DMENU_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Execute:") in
    'firefox')
        /home/drag0n/.i3/firefox.sh
        ;;
    'firefox_unsec')
        if [ -f ~/.gentoo ]; then
            /usr/bin/apulse /usr/bin/firefox-bin -P unsecure &
        elif [ -f ~/.freebsd-thinkpad ]; then
            /usr/local/bin/firefox -P unsecure &
        fi
        ;;
    'telegram')
        if [ -f ~/.gentoo ]; then
            /home/drag0n/bin/telegram/Telegram &
        elif [ -f ~/.freebsd-thinkpad ]; then
            /usr/local/bin/telegram-desktop &
        fi
        ;;
    'keepassxc')
        /usr/bin/env keepassxc &
        ;;
    'audacious')
        /usr/bin/audacious &
        ;;
    'gimp')
        /usr/bin/env gimp &
        ;;
    'openshot')
        /usr/bin/openshot-qt &
        ;;
    'audacity')
        /usr/bin/audacity &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/bin/env qmapshack &
        ;;
    'josm')
        /usr/bin/env java -jar /home/drag0n/bin/josm/josm-tested.jar &
        ;;
    'idea')
        /home/drag0n/bin/idea/bin/idea.sh
        ;;
    'android-file-transfer')
        /usr/bin/env android-file-transfer &
        ;;
    'modes')
        MODES_ITEMS="normal:theatre:night"
        case $(echo $MODES_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Mode:") in
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

