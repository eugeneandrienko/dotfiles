#!/usr/bin/env sh

CAPS_LOCK_STATE=$(DISPLAY=:0 xset q | grep 'Caps Lock:' | sed -r 's/[ \t]+[0-9]+: Caps Lock:[ \t]+([onf]+).*/\1/g')
LANGUAGE=/home/drag0n/.cache/language

case "$CAPS_LOCK_STATE" in
    "off")
        echo "EN" > "$LANGUAGE"
    ;;
    "on")
        echo "RU" > "$LANGUAGE"
    ;;
    "*")
        echo "Unknown language" > "$LANGUAGE"
    ;;
esac
