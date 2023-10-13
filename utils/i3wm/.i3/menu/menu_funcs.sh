#!/usr/bin/env zsh

function f_dmenu() {
    dmenu -i -b -fn '-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u' \
        -sb '#46585e' -sf '#fdf6e3' -nb '#fdf6e3' -nf '#46585e' \
        -p "$1"
}

function parse_items() {
    tr ':' '\n'
}

