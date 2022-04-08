#!/usr/bin/env sh

BRIGHTNESS="/sys/class/backlight/intel_backlight/brightness"
CURRENT_VALUE=$(cat $BRIGHTNESS)
if [ "$1" = "up" ]; then
    OPERATOR="+"
elif [ "$1" = "down" ]; then
    OPERATOR="-"
else
    exit 1
fi
NEW_VALUE=$(echo "$CURRENT_VALUE""$OPERATOR"100 | bc)

echo "$NEW_VALUE" | doas tee "$BRIGHTNESS" > /dev/null

