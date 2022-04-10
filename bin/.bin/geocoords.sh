#!/usr/bin/env zsh

LAT=59.998827
LON=30.194043

if [ "$1" = "lat" ]; then
    echo "$LAT"
elif [ "$1" = "lon" ]; then
    echo "$LON"
else
    echo "$LAT":"$LON"
fi

