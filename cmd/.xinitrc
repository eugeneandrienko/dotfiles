#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

# Setup colors and fonts for different X-server programs:
case "$MACHINE_HW" in
    "zalman")
        xrdb -I$HOME ~/.Xresources &
        ;;
    "thinkpad")
        xrdb -I$HOME ~/.Xresources && \
            xrdb -merge ~/.Xresources.d/thinkpad_x220
        ;;
esac

# Start synchronization daemon:
if ! pgrep -x syncthing > /dev/null; then
    syncthing serve &
fi

# Configure keyboard layout:
case "$MACHINE_HW" in
    "zalman")
        # Remap keys for new unprogrammable kbd:
        setxkbmap -layout us,ru -option grp:caps_select -option grp_led:caps -option compose:ralt
        xmodmap ~/.Xmodmap &
        numlockx on &
        ;;
    "thinkpad")
        setxkbmap -model "thinkpad" -layout us,ru -option grp:shift_caps_switch -option grp_led:caps -option compose:ralt &
        numlockx off &
        ;;
esac

# Configure video output(s):
case "$MACHINE_HW" in
    "zalman")
        xrandr --output DVI-D-0 --primary
        xrandr --output HDMI-0 --auto --right-of DVI-D-0
        ;;
    "thinkpad")
        xrandr --output LVDS-1 --off
        xrandr --output DP-3 --primary
        backlight 0
        xset s off
        xset s noblank
        ;;
esac

# Set wallpaper:
feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/DRG.jpg &

# Start redshift:
~/.bin/redshift.sh

# Start automount service to notify user about mounted devices:
case "$MACHINE_OS" in
    "gentoo")
        udiskie &
        ;;
    "freebsd")
        ;;
esac

exec /usr/bin/env i3 -c ~/.i3/config
