#!/usr/bin/env zsh

ps aux | grep -v 'grep' | grep -q 'redshift -l'
if [ "$?" -ne "0" ]; then
    source ~/.bin/get_machine_id.sh
    case "$MACHINE_OS" in
        "gentoo")
            redshift -l $(~/.bin/geocoords.sh) -m vidmode &
            ;;
        "freebsd")
            redshift -l $(~/.bin/geocoords.sh) -m randr &
            ;;
    esac
fi

