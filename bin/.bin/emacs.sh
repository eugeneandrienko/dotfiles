#!/usr/bin/env bash

function emacs() {
    emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t
    if [ "$?" -eq "1" ]; then
        emacsclient -c -n -a "" "$@"
    else
        emacsclient -n -a "" "$@"
    fi
}

emacs "$@"
