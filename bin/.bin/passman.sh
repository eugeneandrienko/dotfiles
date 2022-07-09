#!/bin/sh -e
#
# Based on http://www.git.stargrave.org/?p=passman.git;a=blob;f=passman
#
# passman -- simple password manager
# Copyright (C) 2013-2021 Sergey Matveev (stargrave@stargrave.org)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

DB="$PASSWORD_STORE_DIR"

generator() {
    gpg --armor --gen-random 1 30 | tr '+/' '-_' | tr -d =
}

cliper() {
    if [ -d ~/.termux ]; then
        if [ "$1" = "primary" ]; then
            termux-clipboard-set
        fi
    else
        xclip -in -selection $1
    fi
}

ENTITY=""

finder() {
    cd $DB
    result=$(find . -type d -path "*$1*" | while read ent; do
        [ -e "$ent/passwd.gpg" ] || continue
        echo "$ent" | sed 's#^\./##'
    done)
    if [ $(echo "$result" | wc -l) -ne 1 ]; then
        echo "$result"
        exit 1
    fi
    [ -n "$result" ] || exit 1
    ENTITY=$result
}

case "$1" in
has)
    finder "$2"
    ;;
gen)
    generator
    ;;
*)
    finder "$1"

    echo "$ENTITY"

    gpg -q --decrypt "$ENTITY"/passwd.gpg | perl -ne 'chop and print' | cliper clipboard
    echo $(basename "$ENTITY") | perl -ne 'chop and print' | cliper primary

    echo -n "Login: "
    echo $(basename "$ENTITY") | perl -ne 'chop and print'; echo

    if [ -e "$ENTITY"/otp.gpg ]; then
        echo -n "OTP: "
        pass otp "$ENTITY/otp"
    fi

    sleep 10
    echo -n | cliper clipboard
    echo -n | cliper primary
    ;;
esac

