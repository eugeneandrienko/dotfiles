#!/usr/bin/env bash

/usr/bin/r2e -c ~/rsync/filez/rss/rss2email.cfg -d ~/rsync/filez/rss/rss2email.json run > /dev/null 2>&1
cd ~/rsync/mail/rss-inbox
find cur new -type f | while read FILENAME; do
    /usr/bin/maildrop < "$FILENAME"
    rm -f "$FILENAME"
done

