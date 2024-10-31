#!/usr/bin/env bash

echo "$1" >> ~/test.log

if [ "$1" -eq 1 ]; then
    emacsclient --eval "(calendar)"
    date '+%Y-%m-%d %T %a'
    exit 33
fi
date '+%Y-%m-%d %T %a'
