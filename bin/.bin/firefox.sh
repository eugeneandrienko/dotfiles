#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

case "$MACHINE_OS" in
    "gentoo")
        if [ -x /usr/bin/apulse ] &&
           [ -x /usr/bin/firefox-bin ]; then
            /usr/bin/apulse /usr/bin/firefox-bin $1 &
        fi
        ;;
    "freebsd")
        /usr/local/bin/firefox $1 &
        ;;
    "*")
        exit 1
        ;;
esac

