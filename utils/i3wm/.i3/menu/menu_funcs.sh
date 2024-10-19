#!/usr/bin/env zsh

function f_dmenu() {
    dmenu -i -b -fn 'Hack-14' \
        -sb '#46585e' -sf '#fdf6e3' -nb '#fdf6e3' -nf '#46585e' \
        -p "$1"
}

function parse_items() {
    tr ':' '\n'
}
