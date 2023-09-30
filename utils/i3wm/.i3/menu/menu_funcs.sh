#!/usr/bin/env zsh

function f_dmenu() {
    dmenu -i -b -fn '-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u' \
        -sb '#000000' -sf '#ffffff' -nb '#ffffff' -nf '#000000' \
        -p "$1"
}

function parse_items() {
    tr ':' '\n'
}
