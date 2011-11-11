#!/bin/bash

PSLIST=`ps -ef`
echo "$PSLIST" | grep -v 'start_dropbox.sh' | grep -q 'dropbox'
if [ "$?" -ne "0" ]; then
    if [ ! "$DISPLAY" == "" ]; then
	echo "`basename $0`: Starting dropbox service..."
	nohup dropbox &
	sleep 1
	rm -fv nohup.out
    else
	echo "`basename $0`: X server not running!"
	exit 1
    fi
else
    echo "`basename $0`: Dropbox already started!"
    exit 1
fi
