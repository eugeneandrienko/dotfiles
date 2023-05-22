#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

case "$MACHINE_OS" in
    "gentoo")
        cal -m -n 3
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

