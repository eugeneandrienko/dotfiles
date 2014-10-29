if [ -e "$HOME/.dell_laptop" ]; then
	xrandr --setprovideroutputsource modesetting NVIDIA-0
	xrandr --auto
fi

##################################################
# Put the line here, which starts your favorite WM
##################################################
i3
