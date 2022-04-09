#!/usr/bin/env sh

if [ -f ~/.gentoo ]; then
    if [ -x /usr/bin/apulse ] &&
       [ -x /usr/bin/firefox-bin ]; then
        /usr/bin/apulse /usr/bin/firefox-bin $1 &
    fi
elif [ -f ~/.debian ]; then
    /usr/bin/firefox $1 &
fi

