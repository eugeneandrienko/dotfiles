#!/bin/bash

EXECLIST="google-chrome\n\
emacs\n\
skype\n\
gimp\n\
audacity\n\
lock"
ECHO="/bin/echo -e"
DMENU='dmenu -b -p "Execute:" -nb black -nf green -sb green -sf black'
RETVAL=`$ECHO $EXECLIST | $DMENU -fn "-*-droid sans mono-*-*-*-*-12-*-*-*-*-*-*-u"`

case "$RETVAL" in
    "google-chrome")
	google-chrome &
	;;
    "emacs")
	emacsclient -c -n &
	;;
    "skype")
	skype &
	;;
    "gimp")
	gimp &
	;;
    "audacity")
	audacity & 
	;;
    "lock")
	/home/drag0n/.bin/xlock.sh
	;;
esac

exit 0
