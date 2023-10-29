#!/usr/bin/env zsh

LAT=59.998827
LON=30.194043
LOC="Saint Petersburg, RU"

if [ "$1" = "lat" ]; then
    echo "$LAT"
elif [ "$1" = "lon" ]; then
    echo "$LON"
elif [ "$1" = "loc" ]; then
    echo "$LOC"
else
    echo "$LAT":"$LON"
fi

