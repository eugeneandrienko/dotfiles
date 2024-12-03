#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

DMENU_ITEMS="librewolf:librewolf_unsec:telegram:syncthing"
DMENU_ITEMS+=":audacious:gimp:rawtherapee:shotwell:shotcut"
DMENU_ITEMS+=":qmapshack:josm:stellarium:xonotic"

case $(echo $DMENU_ITEMS | rofi -dmenu -sep ":" -p "Execute") in
    'librewolf')
        $HOME/.bin/librewolf.sh
        ;;
    'librewolf_unsec')
        if [ "$MACHINE_OS" = "gentoo" ]; then
            /usr/bin/apulse /usr/bin/librewolf -P unsecure &
        elif [ "$MACHINE_OS" = "freebsd" ]; then
            /usr/local/bin/librewolf -P unsecure &
        fi
        ;;
    'telegram')
        $HOME/bin/telegram/Telegram &
        ;;
    'syncthing')
        $HOME/.bin/librewolf.sh https://127.0.0.1:8384/ &
        ;;
    'audacious')
        /usr/bin/env audacious &
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
    'xonotic')
        $HOME/xonotic/xonotic-linux-glx.sh &
        ;;
    *)
        exit 1
        ;;
esac
