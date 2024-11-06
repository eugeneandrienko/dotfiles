#!/usr/bin/env zsh

if [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    ACPI_OUTPUT="$(acpiconf -i 0)"
    BATTERY_STATE="$(echo $ACPI_OUTPUT | grep State: | sed -r 's/State:[ \t]+(.+)$/\1/g')"
    BATTERY_CAPACITY="$(echo $ACPI_OUTPUT | grep 'Remaining capacity:' | sed -r 's/.+city:[ \t]+(.+)%$/\1/g')"
    BATTERY_REMAINING="$(echo $ACPI_OUTPUT | grep 'Remaining time:' | sed -r 's/.+time:[ \t]+(.+)$/\1/g')"
    case $BATTERY_STATE in
        "high")
            echo "🔋"
            ;;
        "charging")
            echo "⚡$BATTERY_CAPACITY%"
        ;;
        "discharging")
            echo "🪫$BATTERY_CAPACITY% $BATTERY_REMAINING"
            echo "🪫$BATTERY_CAPACITY%"
            if [ "$BATTERY_CAPACITY" -le "10" ]; then
                echo "#DC322F"
            fi
        ;;
        *)
            echo "No battery"
            echo "NO BAT"
            echo "#DC322F"
            ;;
    esac
elif [ "$MACHINE_HW" = "zalman" ]; then
    APCUPSD_OUTPUT="$(apcaccess)"
    BATTERY_STATE="$(echo $APCUPSD_OUTPUT | grep 'STATUS' | sed -r 's/.+: (.+) +/\1/g')"
    BATTERY_REMAINING="$(echo $APCUPSD_OUTPUT | grep 'TIMELEFT' | sed -r 's/.+: ([0-9.]+).+/\1 min/g')"
    VOLTAGE="$(echo $APCUPSD_OUTPUT | grep 'LINEV' | sed -r 's/.+: ([0-9.]+).+/\1 V/g')"
    LOAD="$(echo $APCUPSD_OUTPUT | grep 'LOADPCT' | sed -r 's/.+: ([0-9.]+).+/\1/g')"
    MAXPOWER="$(echo $APCUPSD_OUTPUT | grep 'NOMPOWER' | sed -r 's/.+: ([0-9.]+).+/\1/g')"
    LOAD=$(echo "$LOAD / 100 * $MAXPOWER" | bc -l | sed -r 's/([0-9]+\.[0-9]).+/\1/g')
    LOAD+=" W"
    case "$BATTERY_STATE" in
        "ONLINE")
            echo "🔋$BATTERY_REMAINING $VOLTAGE $LOAD"
            ;;
        "ONBATT")
            echo "🪫$BATTERY_REMAINING $LOAD"
            echo "#DC322F"
            ;;
        *)
            echo "No UPS battery"
            echo "NO BAT"
            echo "#DC322F"
            ;;
    esac
fi
