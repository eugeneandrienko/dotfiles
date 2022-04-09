#!/usr/bin/env zsh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

if [ -f ~/.zalman ]; then
    DMENU_ITEMS="firefox:firefox_unsec:telegram"
    DMENU_ITEMS+=":audacious:gimp:rawtherapee:openshot"
    DMENU_ITEMS+=":qmapshack:josm:stellarium"
    DMENU_ITEMS+=":idea:android-file-transfer"
elif [ -f ~/.thinkpad ]; then
    DMENU_ITEMS="firefox:firefox_unsec:telegram"
    DMENU_ITEMS+=":gimp:rawtherapee"
    DMENU_ITEMS+=":qmapshack:josm:stellarium"
    DMENU_ITEMS+=":idea:android-file-transfer"
fi

case $(echo $DMENU_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Execute:") in
    'firefox')
        /home/drag0n/.bin/firefox.sh
        ;;
    'firefox_unsec')
        if [ -f ~/.gentoo ]; then
            /usr/bin/apulse /usr/bin/firefox-bin -P unsecure &
        elif [ -f ~/.debian ]; then
            /usr/bin/firefox -P unsecure &
        fi
        ;;
    'telegram')
        /home/drag0n/bin/telegram/Telegram &
        ;;
    'audacious')
        /usr/bin/audacious &
        ;;
    'gimp')
        /usr/bin/env gimp &
        ;;
    'rawtherapee')
        /usr/bin/env rawtherapee &
        ;;
    'openshot')
        /usr/bin/openshot-qt &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/bin/env qmapshack &
        ;;
    'josm')
        /usr/bin/env java -jar /home/drag0n/bin/josm/josm-tested.jar &
        ;;
    'stellarium')
        /usr/bin/env stellarium &
        ;;
    'idea')
        /home/drag0n/bin/idea/bin/idea.sh
        ;;
    'android-file-transfer')
        /usr/bin/env android-file-transfer &
        ;;
    *)
        exit 1
        ;;
esac

