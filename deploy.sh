#!/usr/bin/env zsh

# Settings:
GITREPO_NAME="dotfiles"

# Are we in the directory with cloned dotfiles repository?
if [ "$(basename "$PWD")" != "$GITREPO_NAME" ] || [ ! -d ".git/" ]; then
    echo "Current directory IS NOT the directory with 'dotfiles' git repository!"
    exit 1
fi

# Some Termux fixes before deploy
if [ -d ~/.termux ]; then
    rm -vf ~/.config/mc/ini
    rm -vf ~/.emacs
fi

# Copying shell configuration to $HOME
export STOW_DIR=.
stow bin cmd

# Copying dotfiles to $HOME
export STOW_DIR=./utils
stow abook ansiweather dunst emacs git gnupg mc mplayer mutt postgresql rtorrent ssh tmux vim zathura
stow --ignore="i3status\.conf\.m4" i3wm

# Making necessary (empty) directories
mkdir -pv "$HOME/.vim/swapfiles"
mkdir -pv "$HOME/.vim/undodir"
mkdir -pv "$HOME/rsync/filez"
mkdir -pv "$HOME/rsync/mail"
mkdir -pv "$HOME/rsync/mail/logs"
mkdir -pv "$HOME/rsync/mail/cache"
mkdir -pv "$HOME/syncthing"

if [ -x /usr/bin/maildirmake ]; then
    MAILDIRMAKE="/usr/bin/maildirmake"
elif [ -x /usr/local/bin/maildrop-maildirmake ]; then
    MAILDIRMAKE="/usr/local/bin/maildrop-maildirmake"
elif [ -x /usr/local/bin/maildirmake ]; then
    MAILDIRMAKE="/usr/local/bin/maildirmake"
fi
$MAILDIRMAKE "$HOME/rsync/mail/banks"
$MAILDIRMAKE "$HOME/rsync/mail/checks"
$MAILDIRMAKE "$HOME/rsync/mail/default"
$MAILDIRMAKE "$HOME/rsync/mail/expresso"
$MAILDIRMAKE "$HOME/rsync/mail/infrastructure"
$MAILDIRMAKE "$HOME/rsync/mail/maillists"
$MAILDIRMAKE "$HOME/rsync/mail/rss-inbox"
$MAILDIRMAKE "$HOME/rsync/mail/rss"
$MAILDIRMAKE "$HOME/rsync/mail/rss-podcasts"
$MAILDIRMAKE "$HOME/rsync/mail/rss-youtube"
$MAILDIRMAKE "$HOME/rsync/mail/social"
$MAILDIRMAKE "$HOME/rsync/mail/state"
$MAILDIRMAKE "$HOME/rsync/mail/stores"

# Create empty .rsyncignore to bootstrap run of sync system
touch "$HOME/rsync/.rsyncignore"

# Create empty ~/.netrc if it not exists
touch $HOME/.netrc

# Create empty OpenWeatherMap API key file
touch $HOME/.openweathermap

# Changing access rights
chmod -v 600 ~/.fdm.conf
chmod -v 600 ~/.mailfilter
chmod -v 600 ~/.msmtprc
chmod -v 600 ~/.netrc
chmod -v 600 ~/.openweathermap

# Installing crontab
echo "Installing crontab"
crontab ./utils/crontab/crontab

# Restart dunst
pkill dunst

# Select target system and OS if not selected yet
if [ -d ~/.termux ]; then
    echo "Termux" > ~/.machine_id
elif [ ! -f ~/.machine_id ]; then
    echo
    echo 'Machine:'
    echo
    echo '1) Gentoo (GNU/Linux) on Zalman'
    echo '2) Debian on Thinkpad'
    echo
    read 'SELECTED_OS?Select machine: '

    case "$SELECTED_OS" in
        '1')
            echo "Gentoo on Zalman" > ~/.machine_id
            ;;
        '2')
            echo "Debian on Thinkpad" > ~/.machine_id
            ;;
        '*')
            echo 'Wrong input!'
            exit 2
            ;;
    esac
fi

# Some fixes for Termux
if [ -d ~/.termux ]; then
    sed -ri 's!skin=/home/drag0n.*!skin=/home/.config/mc/gray-green-purple256.ini!g' ~/.config/mc/ini
    rm -rf ~/.emacs.d/plugins/haskell-mode/
    sed -ri '/haskell/d' ~/.emacs
fi

# m4 some config files
source ~/.bin/get_machine_id.sh
m4 -P -D"$MACHINE_HW" utils/i3wm/.i3/i3status.conf.m4 > ~/.i3/i3status.conf

echo
echo 'Done!'
