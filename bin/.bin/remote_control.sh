#!/usr/bin/env zsh

source ~/.bin/get_machine_id.sh

if [ "$MACHINE_OS" != "gentoo" ]; then
    echo "This script only for Gentoo host!"
    exit 1
fi

if [ $(tmux list-panes | wc -l) != 1 ]; then
    echo "Should be executed on the new tmux window!"
    exit 2
fi


TEMP=$(mktemp /tmp/ssh.tunnel.XXXXXXXXXX)

function trap_ctrl_c()
{
    echo
    echo
    echo "Stopping remote control..."
    sudo pkill -ef "tail -F"
    pkill -ef "ssh -fNTR 0.0.0.0:22222"
    pkill -ef "ssh -fNTR 127.0.0.1:22223"
    sudo pkill -ef "watch -d -n 30 -c"
    mv -vf "$TEMP" ~/ssh_tunnel.log
    sudo rc-service sshd stop
    echo "Remote control stopped"
    exit 0
}

trap trap_ctrl_c INT

if ! pgrep sshd; then
    echo "Starting sshd ..."
    sudo rc-service sshd start
fi

echo "Forward ssh port"
ssh -fNTR 0.0.0.0:22222:localhost:22 drag0n@eugene-andrienko.com

echo "Forward vnc port"
ssh -fNTR 127.0.0.1:22223:192.168.0.40:5900 drag0n@eugene-andrienko.com
# On the other host: ssh -NTL 5900:127.0.0.1:22223 drag0n@eugene-andrienko.com

echo

tmux rename-window tunnel
sudo tail -F /var/log/auth.log | grep --line-buffered 'sshd\[[0-9]\{1,\}\]' | tee -a "$TEMP" &
tmux split-window -v "sudo watch -d -n 30 -c \"netstat -Wtapn | egrep '(192\.168\.0\.40)|([0-9.]+:22[ \t]+)'\""

while true; do
    sleep 60
done

