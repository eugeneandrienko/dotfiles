#!/usr/bin/env bash

MACHINE_ID=$(cat ~/.machine_id)
case "$MACHINE_ID" in
    "Gentoo on Zalman")
        MACHINE_OS="gentoo"
        MACHINE_HW="zalman"
    ;;
    "Debian on Thinkpad")
        MACHINE_OS="debian"
        MACHINE_HW="thinkpad"
    ;;
    "Termux")
        MACHINE_OS="termux"
        MACHINE_HW="termux"
    ;;
esac

export MACHINE_OS
export MACHINE_HW
