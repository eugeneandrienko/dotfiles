#!/usr/bin/env zsh

if [ -f ~/.gentoo ]; then
    setxkbmap -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt
elif [ -f ~/.freebsd-thinkpad ]; then
    setxkbmap -rules "evdev" -model "thinkpad" -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt -keycodes evdev
fi

feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/OUMA_xVt_O8.jpg

if [ -f ~/.gentoo ]; then
    xrandr --output DVI-D-1 --primary
    xrandr --output DVI-D-2 --auto --right-of DVI-D-1
fi

if [ -f ~/.gentoo ]; then
    redshift -l 59.9386300:30.3141300 -m vidmode &
    numlockx
elif [ -f ~/.freebsd-thinkpad ]; then
    redshift -l 59.9386300:30.3141300 -m randr &
fi

if [ -f ~/.freebsd-thinkpad ]; then
    doas sysctl hw.acpi.video.lcd0.brightness=65
fi

if [ -f ~/.gentoo ]; then
    exec /usr/bin/i3 -c ~/.i3/config
elif [ -f ~/.freebsd-thinkpad ]; then
    exec /usr/local/bin/i3 -c ~/.i3/config
fi

