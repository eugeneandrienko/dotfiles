#!/usr/bin/env zsh

ps aux | grep -v 'grep' | grep -q 'redshift -l'
if [ "$?" -ne "0" ]; then
    redshift -l 59.9386300:30.3141300 -m vidmode &
fi

