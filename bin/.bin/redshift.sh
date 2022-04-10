#!/usr/bin/env zsh

ps aux | grep -v 'grep' | grep -q 'redshift -l'
if [ "$?" -ne "0" ]; then
    redshift -l $(~/.bin/geocoords.sh) -m vidmode &
fi

