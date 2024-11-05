#!/usr/bin/env zsh

if [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    WPA_STATUS="$(wpa_cli status)"
    if [ "$?" -eq "0" ]; then
        WPA_STATE="$(echo $WPA_STATUS | grep '^wpa_state=' | sed -r 's/wpa_state=(.+)/\1/g')"
    else
        WPA_STATE="DOWN"
    fi
    case "$WPA_STATE" in
        "DISCONNECTED"|"DOWN")
            echo ""
            ;;
        "SCANNING")
            echo "📶 scan"
            echo "📶"
            echo "#FF8000"
            ;;
        *)
            SSID="$(echo $WPA_STATUS | grep '^ssid=' | sed -r 's/ssid=(.+)/\1/g')"
            IP_ADDRESS="$(echo $WPA_STATUS | grep '^ip_address=' | sed -r 's/ip_address=(.+)/\1/g')"
            echo "$SSID ($IP_ADDRESS)"
            echo "$SSID"
            echo "#2AA198"
            ;;
    esac

    if [ "$BLOCK_BUTTON" -eq 1 ]; then
        i3-msg -q exec wpa_gui
    fi
else
    echo ""
fi
