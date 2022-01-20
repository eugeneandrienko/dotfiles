#!/usr/bin/env sh

if [ -f ~/.gentoo ]; then
    if [ -x /usr/bin/apulse ] &&
       [ -x /usr/bin/firefox-bin ]; then
        /usr/bin/apulse /usr/bin/firefox-bin &
    fi
elif [ -f ~/.freebsd-thinkpad ]; then
    /usr/local/bin/firefox &
fi

