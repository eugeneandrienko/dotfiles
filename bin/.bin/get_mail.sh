#!/usr/bin/env bash

PROXY=0
NO_MU=0

args=$(getopt pm $*)
if [ "$?" -ne "0" ]; then
    echo "Usage:"
    echo "$0 [-p]"
    echo "-p Use proxy on 127.0.0.1"
    echo "-m Do not run mu"
    echo
    exit 1
fi

set -- $args

while :; do
    case "$1" in
        -p)
            PROXY=1
            shift
            ;;
        -m)
            NO_MU=1
            shift
            ;;
        --)
            shift
            break
            ;;
    esac
done

################################################################################
### Get mail:
################################################################################
fdm -v fetch

################################################################################
### Get RSS:
################################################################################
function remove_rss_dups() {
    cd $1/new

    if [ $(ls | wc -l) -eq 0 ]; then
        return
    fi

    # Search for duplicates in new mails:
    for NEW_MAIL in *; do
        SUBJECT="$(grep -h 'Subject: ' $NEW_MAIL)"

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
}

if [ "$PROXY" -eq "1" ]; then
    export http_proxy="127.0.0.1:20172"
    export https_proxy="127.0.0.1:20172"
    PROXY="_proxy"
else
    PROXY=""
fi

if [ $(ps aux | grep -v grep | grep $0 | wc -l) -gt 2 ]; then
    exit 0;
fi

r2e -c ~/rsync/mail/rss2email"$PROXY".cfg -d ~/rsync/mail/rss2email.json run
cd ~/rsync/mail/rss-inbox
find cur new -type f | while read FILENAME; do
    maildrop < "$FILENAME"
    rm -f "$FILENAME"
done

remove_rss_dups ~/rsync/mail/rss
remove_rss_dups ~/rsync/mail/rss-lobsters
remove_rss_dups ~/rsync/mail/rss-podcasts
remove_rss_dups ~/rsync/mail/rss-youtube

################################################################################
### Indexing new mails with mu:
################################################################################
if [ "$NO_MU" -eq 0 ]; then
    mu index
fi
