#!/usr/bin/env sh

if [ -f ~/.gentoo ]; then
    i3status --config ~/.i3/i3status.conf.gentoo
elif [ -f ~/.freebsd-thinkpad ]; then
    i3status --config ~/.i3/i3status.conf.freebsd-thinkpad
fi

