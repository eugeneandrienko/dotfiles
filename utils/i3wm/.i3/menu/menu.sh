#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh
source ~/.i3/menu/menu_funcs.sh

DMENU_ITEMS="firefox:firefox_unsec:telegram:syncthing"
DMENU_ITEMS+=":audacious:gimp:rawtherapee:shotwell:shotcut"
DMENU_ITEMS+=":qmapshack:josm:stellarium"
DMENU_ITEMS+=":idea:umlet"
DMENU_ITEMS+=":android-file-transfer"
DMENU_ITEMS+=":homm3"

case $(echo $DMENU_ITEMS | parse_items | f_dmenu 'Execute:') in
    'firefox')
        $HOME/.bin/firefox.sh
        ;;
    'firefox_unsec')
        if [ "$MACHINE_OS" = "gentoo" ]; then
            /usr/bin/apulse /usr/bin/firefox-bin -P unsecure &
        elif [ "$MACHINE_OS" = "freebsd" ]; then
            /usr/bin/firefox -P unsecure &
        fi
        ;;
    'telegram')
        $HOME/bin/telegram/Telegram &
        ;;
    'syncthing')
        $HOME/.bin/firefox.sh https://127.0.0.1:8384/ &
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
        /usr/bin/env shotcut &
        ;;
    'qmapshack')
         LC_MESSAGES="ru_RU.utf8" /usr/bin/env qmapshack &
        ;;
    'josm')
        if [ "$MACHINE_OS" = "gentoo" ]; then
            /usr/bin/env java \
                --add-exports=java.base/sun.security.action=ALL-UNNAMED \
                --add-exports=java.desktop/com.sun.imageio.plugins.jpeg=ALL-UNNAMED \
                --add-exports=java.desktop/com.sun.imageio.spi=ALL-UNNAMED \
                -jar $HOME/bin/josm/josm-tested.jar &
        elif [ "$MACHINE_OS" = "freebsd" ]; then
            GDK_SCALE=2 /usr/bin/env java \
                --add-exports=java.base/sun.security.action=ALL-UNNAMED \
                --add-exports=java.desktop/com.sun.imageio.plugins.jpeg=ALL-UNNAMED \
                --add-exports=java.desktop/com.sun.imageio.spi=ALL-UNNAMED \
                -jar $HOME/bin/josm/josm-tested.jar &
        fi
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
    'homm3')
        cd $HOME/homm3 && wine HD_Launcher.exe &
        ;;
    *)
        exit 1
        ;;
esac
