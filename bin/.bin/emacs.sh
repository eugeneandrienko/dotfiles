#!/usr/bin/env bash

function emacsfunc() {
    PARENT_PROGRAM=$(ps -o comm= $PPID)
    EMACS_CMD="emacsclient"
    emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t

    if [ "$?" -eq "1" ]; then
        # No Emacs frames — need to create a new one:
        EMACS_CMD="$EMACS_CMD -c"
    fi
    if [[ ! "mutt git bash zsh crontab" =~ "$PARENT_PROGRAM" ]]; then
        # Shouldn't wait for buffer in Emacs — return immediately:
        EMACS_CMD="$EMACS_CMD -n"
    fi
    # No alternate editor — start daemon if it is not running:
    EMACS_CMD="$EMACS_CMD -a \"\""
    eval "$EMACS_CMD $@"
}

emacsfunc "$@"

