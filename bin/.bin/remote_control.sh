#!/usr/bin/env zsh

if [ ! -f ~/.gentoo ]; then
    echo "This script only for Gentoo host!"
    exit 1
fi

trap 'echo "Stopping remote control..."; pkill -f "ssh -fNTR 0.0.0.0:22222"; doas rc-service sshd stop; echo "Remote control stopped"' INT

if ! pgrep sshd; then
    echo "SSHD not started! Starting it..."
    doas rc-service sshd start
fi

echo "Forward ssh port"
ssh -fNTR 0.0.0.0:22222:localhost:22 drag0n@eugene-andrienko.com

echo "Forward vnc port"
ssh -NTR 127.0.0.1:22223:192.168.0.40:5900 drag0n@eugene-andrienko.com
# On the other host: ssh -NTL 5900:127.0.0.1:22223 drag0n@eugene-andrienko.com

