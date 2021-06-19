#!/usr/bin/env zsh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"
echo $DMENU_CMD

DMENU_ITEMS="firefox:firefox_unsec:telegram:keepassxc"
DMENU_ITEMS+=":audacious:gimp:openshot:audacity"
DMENU_ITEMS+=":qmapshack:josm"
DMENU_ITEMS+=":idea:android-file-transfer"
DMENU_ITEMS+=":modes"

case $(echo $DMENU_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Execute:") in
    'firefox')
        /home/drag0n/.i3/firefox.sh
        ;;
    'firefox_unsec')
        /usr/bin/apulse /usr/bin/firefox-bin -P unsecure &
        ;;
    'telegram')
        /home/drag0n/bin/telegram/Telegram &
        ;;
    'keepassxc')
        /usr/bin/keepassxc &
        ;;
    'audacious')
        /usr/bin/audacious &
        ;;
    'gimp')
        /usr/bin/gimp &
        ;;
    'openshot')
        /usr/bin/openshot-qt &
        ;;
    'audacity')
        /usr/bin/audacity &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/bin/qmapshack &
        ;;
    'josm')
        /usr/bin/java -jar /home/drag0n/bin/josm/josm-tested.jar &
        ;;
    'idea')
        /home/drag0n/bin/idea/bin/idea.sh
        ;;
    'android-file-transfer')
        /usr/bin/android-file-transfer &
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

