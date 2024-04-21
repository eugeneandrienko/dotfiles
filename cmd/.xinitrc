#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

# Setup cpu frequency:
if [ "$MACHINE_HW" = "thinkpad" ]; then
    sudo cpupower frequency-set -d 800MHz -u 1GHz -g powersave
    sudo cpupower set -b 8
fi

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

# Set wallpaper:
feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/DRG.jpg &

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

# Start redshift:
~/.bin/redshift.sh

# Start udiskie
udiskie &

exec /usr/bin/i3 -c ~/.i3/config
