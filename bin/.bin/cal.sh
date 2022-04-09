#!/usr/bin/env sh

if [ -f ~/.gentoo ]; then
    cal -n 3
elif [ -f ~/.debian ]; then
    ncal -3Mb
else
    exit 1
fi

