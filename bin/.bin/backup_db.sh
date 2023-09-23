#!/usr/bin/env bash

BACKUP_DIR="$HOME/backups"

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR";
fi

function do_backup()
{
    pg_dump "$1" | gzip > "$BACKUP_DIR"/$(date +%Y-%m-%d_%H:%M:%S)_backup_"$1".gz
}

do_backup money
