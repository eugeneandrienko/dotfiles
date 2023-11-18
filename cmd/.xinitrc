#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

# Setup colors and fonts for different X-server programs:
xrdb -I$HOME ~/.Xresources &

# Start synchronization daemon:
if ! pgrep -x syncthing > /dev/null; then
    syncthing serve &
fi

# Configure keyboard layout:
case "$MACHINE_HW" in
    "zalman")
        setxkbmap -layout us,ru -option grp:caps_select -option grp_led:caps -option compose:ralt &
        numlockx on &
        ;;
    "thinkpad")
        setxkbmap -model "thinkpad" -layout us,ru -option grp:shift_caps_switch -option grp_led:caps -option compose:ralt &
        numlockx off &
        ;;
esac

# Set wallpaper:
feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/14194150900090.png &

# Configure video output(s):
case "$MACHINE_HW" in
    "zalman")
        xrandr --output DVI-D-0 --primary
        xrandr --output HDMI-0 --auto --right-of DVI-D-0
        ;;
    "thinkpad")
        echo 2323 | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null
        xset s off
        xset s noblank
        ;;
esac

# Setup dunst for Devuan:
if [ "$MACHINE_OS" = "debian" ]; then
    sudo pkill xfce4-notifyd
    dunst &
fi

# Start redshift:
~/.bin/redshift.sh

# Start udiskie
udiskie &

exec /usr/bin/i3 -c ~/.i3/config

