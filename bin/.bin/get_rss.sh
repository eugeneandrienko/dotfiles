#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

if [ "$MACHINE_HW" = "zalman" ]; then
    /usr/bin/r2e -c ~/rsync/mail/rss2email.cfg -d ~/rsync/mail/rss2email.json run > /dev/null 2>&1
    cd ~/rsync/mail/rss-inbox
    find cur new -type f | while read FILENAME; do
        /usr/bin/maildrop < "$FILENAME"
        rm -f "$FILENAME"
    done
fi

