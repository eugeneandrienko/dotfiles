#!/usr/bin/env zsh

if [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    WPA_STATUS="$(wpa_cli status)"
    WPA_STATE="$(echo $WPA_STATUS | grep '^wpa_state=' | sed -r 's/wpa_state=(.+)/\1/g')"
    if [ "$WPA_STATE" = "DISCONNECTED" ]; then
        echo ""
    elif [ "$WPA_STATE" = "SCANNING" ]; then
        echo "📶 scan"
        echo "📶"
        echo "#FF8000"
    else
        SSID="$(echo $WPA_STATUS | grep '^ssid=' | sed -r 's/ssid=(.+)/\1/g')"
        IP_ADDRESS="$(echo $WPA_STATUS | grep '^ip_address=' | sed -r 's/ip_address=(.+)/\1/g')"
        echo "$SSID ($IP_ADDRESS)"
        echo "$SSID"
        echo "#2AA198"
    fi

    if [ "$BLOCK_BUTTON" -eq 1 ]; then
        i3-msg -q exec wpa_gui
    fi
else
    echo ""
fi
