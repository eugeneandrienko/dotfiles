#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

# Setup colors and fonts for different X-server programs:
xrdb -I$HOME ~/.Xresources
if [ "$MACHINE_HW" = "thinkpad" ]; then
    xrdb -merge ~/.Xresources.d/thinkpad_x220
fi

# Start synchronization daemon:
if ! pgrep -x syncthing > /dev/null; then
    syncthing serve &
fi

# Configure keyboard layout:
case "$MACHINE_HW" in
    "zalman")
        setxkbmap -layout us,ru -option grp:menu_toggle -option grp_led:caps -option compose:ralt -option shift:both_capslock_cancel -option caps:ctrl_modifier
        xmodmap ~/.xmodmaprc
        ;;
    "thinkpad")
        setxkbmap -model "thinkpad" -layout us,ru -option grp:menu_toggle -option grp_led:caps -option compose:ralt -option shift:both_capslock_cancel -option caps:ctrl_modifier
        xmodmap -e "keycode 147  = ISO_Next_Group Menu ISO_Next_Group Menu"
        ;;
esac
numlockx off &

# Configure video output(s):
case "$MACHINE_HW" in
    "zalman")
        xrandr --output DVI-D-0 --primary
        xrandr --output HDMI-0 --auto --right-of DVI-D-0
        ;;
    "thinkpad")
        xrandr --output DP-3 --primary
        backlight 0
        xset s off
        xset s noblank
        xset -dpms
        xrandr --output LVDS-1 --off
        brightness_agan2k -b 10
        ;;
esac

# Set wallpaper:
feh --image-bg "#000000" --bg-center --no-fehbg /home/drag0n/rsync/filez/wallpaperz/scarletspectrum_adine.png &

# Start redshift:
~/.bin/redshift.sh

# Start automount service to notify user about mounted devices:
if [ "$MACHINE_OS" = "gentoo" ]; then
    udiskie &
fi

picom --config ~/.config/picom.conf --daemon

conky -c ~/.config/conky/conky-left.conf
conky -c ~/.config/conky/conky-right.conf

nohup /usr/bin/env emacs --daemon &
rm -f nohup.out ~/nohup.out

exec /usr/bin/env i3 -c ~/.i3/config
