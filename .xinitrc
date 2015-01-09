if [ -e "$HOME/.dell_laptop" ]; then
	xrandr --setprovideroutputsource modesetting NVIDIA-0
	xrandr --auto
fi

numlockx &
xrdb ~/.xdefaults
setxkbmap -layout us,ru -option grp:caps_toggle,grp_led:caps
xcompmgr -c -o 0.6 -r 12 &
feh --bg-fill /home/drag0n/Dropbox/filez/wallpaperz/b507fc6d75e80e2e909d32eced6e4547.jpg
xsetroot -cursor_name left_ptr


##################################################
# Put the line here, which starts your favorite WM
##################################################
i3
