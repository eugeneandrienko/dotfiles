#!/usr/bin/env sh

if [ -f ~/.zalman ]; then
    i3status --config ~/.i3/i3status.conf.zalman
elif [ -f ~/.thinkpad ]; then
    i3status --config ~/.i3/i3status.conf.thinkpad
fi

