setxkbmap -rules "evdev" -model "thinkpad" -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt -keycodes evdev
feh --bg-fill --no-fehbg /home/drag0n/rsync/filez/wallpaperz/OUMA_xVt_O8.jpg
redshift -l 59.9386300:30.3141300 -m randr &
exec /usr/local/bin/i3 -c ~/.i3/config

