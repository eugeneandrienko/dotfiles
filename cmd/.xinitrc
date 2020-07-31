setxkbmap -layout us,ru -option grp:caps_toggle -option grp_led:caps -option compose:ralt
feh --bg-scale --no-fehbg ~/Dropbox/filez/wallpaperz/pinkie_pie_wall_by_green_fur_ball-d47y2u9.jpg
xrandr --output DVI-D-1 --primary
xrandr --output DVI-D-2 --auto --right-of DVI-D-1
redshift -l 59.9386300:30.3141300 -m vidmode &
numlockx
exec /usr/bin/i3 -c ~/.i3/config

