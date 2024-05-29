#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

FORCE=0
if [ "$1" = "--force" ]; then
    FORCE=1
fi

if [ "$MACHINE_HW" = "zalman" ] || [ "$FORCE" -eq 1 ]; then
    if [ $(ps aux | grep -v grep | grep $0 | wc -l) -gt 2 ]; then
        exit 0;
    fi

    r2e -c ~/rsync/mail/rss2email.cfg -d ~/rsync/mail/rss2email.json run > /dev/null 2>&1
    cd ~/rsync/mail/rss-inbox
    find cur new -type f | while read FILENAME; do
        maildrop < "$FILENAME"
        rm -f "$FILENAME"
    done

    ~/.bin/remove_rss_dups.sh ~/rsync/mail/rss
    ~/.bin/remove_rss_dups.sh ~/rsync/mail/rss-podcasts
    ~/.bin/remove_rss_dups.sh ~/rsync/mail/rss-youtube
fi
