#!/bin/sh
while :; do
    echo -n "> "
    read pass
    passman.sh has "$pass" && break
done
exec passman.sh "$pass"

