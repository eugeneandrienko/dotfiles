#!/usr/bin/env bash

MACHINE_ID=$(cat ~/.machine_id)
case "$MACHINE_ID" in
    "Gentoo on Zalman")
        MACHINE_OS="gentoo"
        MACHINE_HW="zalman"
    ;;
    "FreeBSD on Thinkpad")
        MACHINE_OS="freebsd"
        MACHINE_HW="thinkpad"
    ;;
esac

export MACHINE_OS
export MACHINE_HW
