#!/usr/bin/env zsh

if [ -f ~/.zalman ]; then
    setxkbmap -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt
elif [ -f ~/.thinkpad ]; then
    setxkbmap -model "thinkpad" -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt
fi

feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/OUMA_xVt_O8.jpg

if [ -f ~/.zalman ]; then
    xrandr --output DVI-D-1 --primary
    xrandr --output HDMI-3 --auto --right-of DVI-D-1
fi

if [ -f ~/.zalman ]; then
    numlockx
fi
~/.bin/redshift.sh

if [ -f ~/.thinkpad ]; then
    echo 2323 | doas tee /sys/class/backlight/intel_backlight/brightness > /dev/null
    xset s off
    xset s noblank
fi

xrdb ~/.Xresources

exec /usr/bin/i3 -c ~/.i3/config

