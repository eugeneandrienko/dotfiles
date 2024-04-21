#!/usr/bin/env sh

CURRENT_VALUE=$(brightness_agan2k)
MAX_VALUE=15

if [ "$1" = "up" ]; then
    OPERATOR="+"
elif [ "$1" = "down" ]; then
    OPERATOR="-"
else
    exit 1
fi
NEW_VALUE=$(echo "$CURRENT_VALUE""$OPERATOR"1 | bc)
if [ "$NEW_VALUE" -lt "0" ]; then
    NEW_VALUE=0
elif [ "$NEW_VALUE" -gt "15" ]; then
    NEW_VALUE=15
fi
PERCENTAGE=$(printf %0.f $(echo "$NEW_VALUE"/"$MAX_VALUE"*100 | bc -l))

brightness_agan2k -b "$NEW_VALUE"
dunstify -h string:x-dunst-stack-tag:brightness -h int:value:"$PERCENTAGE" -t 1200 "Brightness:"
