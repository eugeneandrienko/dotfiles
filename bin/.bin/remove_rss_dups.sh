#!/usr/bin/env bash

cd $1/new

if [ $(ls | wc -l) -eq 0 ]; then
    exit
fi

# Search for duplicates in new mails:
for NEW_MAIL in *; do
    SUBJECT="$(/bin/grep -h 'Subject: ' $NEW_MAIL)"

    # Search for duplicates in cur/ directory:
    if [ $(ls ../cur | wc -l) -gt 0 ]; then
        grep -q "$SUBJECT" ../cur/*
        if [ "$?" -eq 0 ]; then
            rm -f "$NEW_MAIL"
            echo "Found duplicate in cur, remove $NEW_MAIL"
        fi
    fi
    # Search for duplicates in new/ directory:
    if [ $(ls | wc -l) -gt 0 ]; then
        DUPS_QTY_IN_NEW=$(grep "$SUBJECT" * | wc -l)
        if [ "$DUPS_QTY_IN_NEW" -gt 1 ]; then
            rm -f "$NEW_MAIL"
            echo "Found duplicate in new, remove $NEW_MAIL"
        fi
    fi
done
