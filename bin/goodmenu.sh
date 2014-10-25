#!/bin/bash

FONT='-xos4-terminus-*-*-*-*-14-*-*-*-*-*-*-u'
cat << EOF | dmenu -p "Execute:" -l 3 -i -b -fn $FONT | xargs bash -c
chrome
gvim
enable_touchpad
disable_touchpad
EOF
