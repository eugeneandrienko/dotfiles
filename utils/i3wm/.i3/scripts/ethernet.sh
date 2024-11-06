#!/usr/bin/env zsh

if [ "$MACHINE_HW" = "thinkpad" ] && [ "$MACHINE_OS" = "freebsd" ]; then
    IP_ADDRESS=$(ifconfig em0 | grep inet | sed -r 's/[ \t]+inet ([0-9.]+) .+/\1/g')
    if [ "$?" -ne 0 ]; then
        echo "eth is down"
        echo "eth down"
        echo "#DC322F"
    fi
    echo $IP_ADDRESS
    echo $IP_ADDRESS
    echo "#2AA198"
elif [ "$MACHINE_HW" = "zalman" ]; then
    IP_ADDRESS=$(ifconfig enp5s0 | grep inet | sed -r 's/[ \t]+inet ([0-9.]+) .+/\1/g')
    if [ "$?" -ne 0 ]; then
        echo "enp5s0 is down"
        echo "enp5s0 down"
        echo "$DC322F"
    fi
    echo $IP_ADDRESS
    echo $IP_ADDRESS
    echo "#2AA198"
fi
