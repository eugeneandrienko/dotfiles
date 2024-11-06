#!/usr/bin/env zsh

if [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    CPU_LOAD="$(uptime | sed -r 's/.+ages: ([0-9.]+),.+/\1/g')"
    CPU_TEMP="$(sysctl -n hw.acpi.thermal.tz0.temperature | sed 's/C//g')"
    echo "🧠$CPU_LOAD $CPU_TEMP°C"
    echo "🧠$CPU_LOAD $CPU_TEMP°C"
    if [ 1 -eq "$(echo $CPU_TEMP '>' 80 | bc)" ]; then
        echo "#DC322F"
    fi
elif [ "$MACHINE_HW" = "zalman" ]; then
    CPU_LOAD="$(uptime | sed -r 's/.+age: ([0-9.]+),.+/\1/g')"
    CPU_TEMP="$(cat /sys/class/thermal/thermal_zone0/temp)"
    CPU_TEMP=$(echo "$CPU_TEMP / 1000" | bc -l | sed -r 's/([0-9]+)\.[0-9]*/\1/g')
    echo "🧠$CPU_LOAD $CPU_TEMP°C"
    echo "🧠$CPU_LOAD $CPU_TEMP°C"
    if [ 1 -eq "$(echo $CPU_TEMP '>' 80 | bc)" ]; then
        echo "#DC322F"
    fi
fi
