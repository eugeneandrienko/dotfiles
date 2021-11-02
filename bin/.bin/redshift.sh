#!/usr/bin/env zsh

ps aux | grep -v 'grep' | grep -q 'redshift -l'
if [ "$?" -ne "0" ]; then
    if [ -f ~/.gentoo ]; then
        redshift -l 59.9386300:30.3141300 -m vidmode &
    elif [ -f ~/.freebsd-thinkpad ]; then
        redshift -l 59.9386300:30.3141300 -m randr &
    fi
fi

