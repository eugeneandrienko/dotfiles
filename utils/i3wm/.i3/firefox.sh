#!/usr/bin/env sh

# Remove nogroups from /etc/firejail/firefox-common.profile if no sound in Firefox
if [ -x /usr/bin/firejail ] &&
    [ -x /usr/bin/apulse ] &&
    [ -x /usr/bin/firefox-bin ] &&
    [ -r /etc/firejail/firefox.profile ]; then
    firejail --profile=/etc/firejail/firefox.profile \
    --whitelist=~/downloads/ \
    /usr/bin/apulse /usr/bin/firefox-bin &
fi

