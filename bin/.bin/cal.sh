#!/usr/bin/env sh

source ~/.bin/get_machine_id.sh

case "$MACHINE_OS" in
    "gentoo")
        cal -n 3
        ;;
    "debian")
        ncal -3Mb
        ;;
    "termux")
        cal -n 1
        ;;
    "*")
        exit 1
        ;;
esac

