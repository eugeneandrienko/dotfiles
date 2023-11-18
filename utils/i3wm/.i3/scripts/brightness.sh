#!/usr/bin/env sh

BRIGHTNESS="/sys/class/backlight/intel_backlight/brightness"
BRIGHTNESS_MAX="/sys/class/backlight/intel_backlight/max_brightness"
CURRENT_VALUE=$(cat $BRIGHTNESS)
MAX_VALUE=$(cat $BRIGHTNESS_MAX)

if [ "$1" = "up" ]; then
    OPERATOR="+"
elif [ "$1" = "down" ]; then
    OPERATOR="-"
else
    exit 1
fi
NEW_VALUE=$(echo "$CURRENT_VALUE""$OPERATOR"100 | bc)
PERCENTAGE=$(printf %0.f $(echo "$NEW_VALUE"/"$MAX_VALUE"*100 | bc -l))

echo "$NEW_VALUE" | sudo tee "$BRIGHTNESS" > /dev/null
dunstify -h string:x-dunst-stack-tag:brightness -h int:value:"$PERCENTAGE" -t 1200 "Brightness:"

