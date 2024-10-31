#!/usr/bin/env zsh

if [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    ACPI_OUTPUT="$(acpiconf -i 0)"
    BATTERY_STATE="$(echo $ACPI_OUTPUT | grep State: | sed -r 's/State:[ \t]+(.+)$/\1/g')"
    BATTERY_CAPACITY="$(echo $ACPI_OUTPUT | grep 'Remaining capacity:' | sed -r 's/.+city:[ \t]+(.+)%$/\1/g')"
    BATTERY_REMAINING="$(echo $ACPI_OUTPUT | grep 'Remaining time:' | sed -r 's/.+time:[ \t]+(.+)$/\1/g')"
    case $BATTERY_STATE in
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
else
    echo ""
fi
