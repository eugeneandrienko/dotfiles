#!/usr/bin/env zsh

FONT="'-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'"
COLORS="-sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000'"
DMENU_CMD="dmenu -i -b -fn $FONT $COLORS"

source ~/.bin/get_machine_id.sh

if [ "$MACHINE_HW" = "zalman" ]; then
    DMENU_ITEMS="firefox:firefox_unsec:telegram"
    DMENU_ITEMS+=":audacious:gimp:rawtherapee:shotwell:shotcut"
    DMENU_ITEMS+=":qmapshack:josm:stellarium"
    DMENU_ITEMS+=":idea:umlet"
    DMENU_ITEMS+=":android-file-transfer"
    DMENU_ITEMS+=":homm3"
elif [ "$MACHINE_HW" = "thinkpad" ]; then
    DMENU_ITEMS="firefox:firefox_unsec:telegram"
    DMENU_ITEMS+=":gimp:rawtherapee:shotwell"
    DMENU_ITEMS+=":qmapshack:josm:stellarium"
    DMENU_ITEMS+=":idea:umlet"
    DMENU_ITEMS+=":android-file-transfer:blueman"
    DMENU_ITEMS+=":homm3"
fi

case $(echo $DMENU_ITEMS | tr ':' '\n' | eval "$DMENU_CMD -p Execute:") in
    'firefox')
        $HOME/.bin/firefox.sh
        ;;
    'firefox_unsec')
        if [ "$MACHINE_OS" = "gentoo" ]; then
            /usr/bin/apulse /usr/bin/firefox-bin -P unsecure &
        elif [ "$MACHINE_OS" = "debian" ]; then
            /usr/bin/firefox -P unsecure &
        fi
        ;;
    'telegram')
        $HOME/bin/telegram/Telegram &
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
    'shotwell')
        /usr/bin/env shotwell &
        ;;
    'shotcut')
        /usr/bin/shotcut &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/bin/env qmapshack &
        ;;
    'josm')
        /usr/bin/env java -jar $HOME/bin/josm/josm-tested.jar &
        ;;
    'stellarium')
        /usr/bin/env stellarium &
        ;;
    'idea')
        $HOME/bin/idea/bin/idea.sh
        ;;
    'umlet')
        $HOME/bin/umlet/umlet.sh &
        ;;
    'android-file-transfer')
        /usr/bin/env android-file-transfer &
        ;;
    'blueman')
        /usr/bin/env blueman-manager &
        ;;
    'homm3')
        cd $HOME/homm3 && wine HD_Launcher.exe &
        ;;
    *)
        exit 1
        ;;
esac
