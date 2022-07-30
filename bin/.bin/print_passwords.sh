#!/usr/bin/env bash

echo "Will output to ./pass.txt"
read -p "Press Enter to continue... " DONOTUSABLE
TXT="$(pwd)/pass.txt"

# Preparing TXT document:
echo "Site Username Password" > $TXT

# Inserting passwords in document:
cd $PASSWORD_STORE_DIR
RESULT=$(find . -type d | while read ENT; do
    [ -e "$ENT/passwd.gpg" ] || continue
    echo "$ENT" | sed 's#^\./##'
done)

echo "$RESULT" | while read ENT; do
    SITE=$(echo $ENT | awk -F'/' '{print $3}')
    USER=$(echo $ENT | awk -F'/' '{print $4}')
    PASS=$(gpg -q --decrypt "$ENT"/passwd.gpg | perl -ne 'chop and print')

    SITE=$(echo "$SITE" | sed 's/ /-/g')
    if [ -z "$USER" ]; then
        USER="NULL"
    fi

    echo "$SITE $USER $PASS" >> $TXT
done

column -t -s " " $TXT > $TXT.temp
mv $TXT.temp $TXT
shred -uz $TXT.temp
echo "Complete!"
echo "Plain text passwords in $TXT"

