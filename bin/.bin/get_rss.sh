#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh

FORCE=0
PROXY=0

args=$(getopt fp $*)
if [ "$?" -ne "0" ]; then
    echo "Usage:"
    echo "$0 [-fp]"
    echo "-f Force run"
    echo "-p Use proxy on 127.0.0.1"
    echo
    exit 1
fi

set -- $args

while :; do
    case "$1" in
        -f)
            FORCE=1
            shift
            ;;
        -p)
            PROXY=1
            shift
            ;;
        --)
            shift
            break
            ;;
    esac
done

if [ "$PROXY" -eq "1" ]; then
    export http_proxy="127.0.0.1:20171"
    export https_proxy="127.0.0.1:20171"
    PROXY="_proxy"
else
    PROXY=""
fi

if [ "$MACHINE_HW" = "zalman" ] || [ "$FORCE" -eq 1 ]; then
    if [ $(ps aux | grep -v grep | grep $0 | wc -l) -gt 2 ]; then
        exit 0;
    fi

    if [ "$FORCE" -eq 1 ]; then
        r2e -c ~/rsync/mail/rss2email"$PROXY".cfg -d ~/rsync/mail/rss2email.json run
    else
        r2e -c ~/rsync/mail/rss2email"$PROXY".cfg -d ~/rsync/mail/rss2email.json run > /dev/null 2>&1
    fi
    cd ~/rsync/mail/rss-inbox
    find cur new -type f | while read FILENAME; do
        maildrop < "$FILENAME"
        rm -f "$FILENAME"
    done

    ~/.bin/remove_rss_dups.sh ~/rsync/mail/rss
    ~/.bin/remove_rss_dups.sh ~/rsync/mail/rss-podcasts
    ~/.bin/remove_rss_dups.sh ~/rsync/mail/rss-youtube
fi
