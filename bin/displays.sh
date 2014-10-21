#!/bin/bash

function check_connection {
    xrandr | grep "$1" | awk '{print $2}' | grep -q -v 'disconnected'
    if [ "$?" -ne "0" ]; then
	echo  "$1 is not connected"
	exit 1
    fi
}

if [ "$DISPLAY" == "" ]; then
    echo "X server not started!"
    exit 1
fi

TEMPFILE=`mktemp /tmp/displays.XXXXXX`

dialog --menu "Select mode" 40 80 30 \
"1m" "One main display (1280x800)" \
"2m1r" "Main display (1280x800) and second (1024x768) right" \
"2m1l" "Main display (1280x800) and second (1024x768) left" \
"2m2" "Main display (1280x800) and second (1280x960)" \
2>"$TEMPFILE"

SELITEM=`cat "$TEMPFILE"`
rm -f "$TEMPFILE"

clear

case "$SELITEM" in
    "1m")
        xrandr --fb 1280x800 --output LVDS1 --primary --mode 1280x800 \
--pos 0x0 --output VGA1 --off
        ;;
    "2m1r")
        check_connection "VGA1"
	xrandr --fb 2304x800 --output LVDS1 --primary --mode 1280x800 \
--pos 0x0 --output VGA1 --mode 1024x768 --pos 1280x0
	;;
    "2m1l")
	check_connection "VGA1"
	xrandr --fb 2304x800 --output VGA1 --mode 1024x768 \
--pos 0x0 --output LVDS1 --primary --mode 1280x800 --pos 1024x0
	;;
    "2m2")
	check_connection "VGA1"
	xrandr --fb 2560x960 --output LVDS1 --primary --mode 1280x800 \
--pos 0x0 --output VGA1 --mode 1280x960 --pos 1280x0
	;;
esac
