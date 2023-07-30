#!/bin/sh
while :; do
    echo -n "> "
    read pass
    $HOME/.bin/passman.sh has "$pass" && break
done
exec $HOME/.bin/passman.sh "$pass"

