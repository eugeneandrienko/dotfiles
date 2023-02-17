#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

case "$MACHINE_HW" in
    "zalman")
        setxkbmap -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt
        ;;
    "thinkpad")
        setxkbmap -model "thinkpad" -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt
        ;;
esac

feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/navi.jpg

if [ "$MACHINE_HW" = "zalman" ]; then
    xrandr --output DVI-D-1 --primary
    xrandr --output HDMI-3 --auto --right-of DVI-D-1
    numlockx
fi

~/.bin/redshift.sh

if [ "$MACHINE_HW" = "thinkpad" ]; then
    echo 2323 | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null
    xset s off
    xset s noblank
fi

xrdb ~/.Xresources
xrdb -merge  ~/.urxvt

exec /usr/bin/i3 -c ~/.i3/config
