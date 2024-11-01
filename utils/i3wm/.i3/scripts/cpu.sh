#!/usr/bin/env zsh

if [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    CPU_LOAD="$(uptime | sed -r 's/.+ages: ([0-9.]+),.+/\1/g')"
    CPU_TEMP="$(sysctl -n hw.acpi.thermal.tz0.temperature | sed 's/C//g')"
    echo "🧠$CPU_LOAD $CPU_TEMP°C"
    echo "🧠$CPU_LOAD $CPU_TEMP°C"
    if [ 1 -eq "$(echo $CPU_TEMP '>' 80 | bc)" ]; then
        echo "#DC322F"
    fi
else
    echo ""
fi
