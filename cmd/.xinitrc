#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

# Start synchronization daemon:
if ! pgrep -x syncthing > /dev/null; then
    syncthing serve &
fi

# Configure keyboard layout:
case "$MACHINE_HW" in
    "zalman")
        setxkbmap -layout us,ru -option grp:caps_select -option grp_led:caps -option compose:ralt
        numlockx on
        ;;
    "thinkpad")
        setxkbmap -model "thinkpad" -layout us,ru -option grp:shift_caps_switch -option grp_led:caps -option compose:ralt
        numlockx off
        ;;
esac

# Set wallpaper:
feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/14194150900090.png

# Configure video output(s):
case "$MACHINE_HW" in
    "zalman")
        xrandr --output DVI-D-1 --primary
        xrandr --output HDMI-3 --auto --right-of DVI-D-1
        ;;
    "thinkpad")
        echo 2323 | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null
        xset s off
        xset s noblank
        ;;
esac

# Start redshift:
~/.bin/redshift.sh

# Setup colors for different X-server programs:
xrdb ~/.Xresources
xrdb -merge  ~/.urxvt

exec /usr/bin/i3 -c ~/.i3/config
