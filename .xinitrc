if [ -e "$HOME/.dell_laptop" ]; then
	xrandr --setprovideroutputsource modesetting NVIDIA-0
	xrandr --auto
fi

numlockx &
xrdb ~/.xdefaults
setxkbmap -layout us,ru -option grp:caps_toggle,grp_led:caps
xsetroot -cursor_name left_ptr
xcompmgr -c -o 0.6 -r 12 &
feh --bg-fill /home/drag0n/Dropbox/filez/wallpaperz/0b1347b8ae66.jpg


##################################################
# Put the line here, which starts your favorite WM
##################################################
i3
