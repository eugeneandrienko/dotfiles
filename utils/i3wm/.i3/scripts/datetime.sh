#!/usr/bin/env bash

if [ "$BLOCK_BUTTON" -eq 1 ]; then
    emacsclient --eval "(calendar)"
    date '+%Y-%m-%d %T %a'
    exit 33
fi
date '+%Y-%m-%d %T %a'
