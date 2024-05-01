#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

case "$MACHINE_OS" in
    "gentoo")
        cal -m -n 3
        ;;
    "freebsd")
        ncal -3
        ;;
    "*")
        exit 1
        ;;
esac

