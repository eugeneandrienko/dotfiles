#!/usr/bin/env zsh

ps aux | grep -v 'grep' | grep -q 'redshift -l'
if [ "$?" -eq "0" ]; then
    pkill -9 redshift
fi
source ~/.bin/get_machine_id.sh
case "$MACHINE_OS" in
    "gentoo")
        redshift -l $(~/.bin/geocoords.sh) -m vidmode &
        ;;
    "freebsd")
        redshift -l $(~/.bin/geocoords.sh) -m randr &
        ;;
esac
