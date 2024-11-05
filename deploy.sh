#!/usr/bin/env zsh

# Settings:
GITREPO_NAME="dotfiles"

# Are we in the directory with cloned dotfiles repository?
if [ "$(basename "$PWD")" != "$GITREPO_NAME" ] || [ ! -d ".git/" ]; then
    echo "Current directory IS NOT the directory with 'dotfiles' git repository!"
    exit 1
fi

# Copying shell configuration to $HOME
export STOW_DIR=.
stow bin cmd

# Copying dotfiles to $HOME
export STOW_DIR=./utils
stow abook conky dunst emacs git gnupg i3wm mplayer mail picom rtorrent ssh

# Making necessary (empty) directories
mkdir -pv "$HOME/.emacs.d/desktop"
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
$MAILDIRMAKE "$HOME/rsync/mail/osm"
$MAILDIRMAKE "$HOME/rsync/mail/rss-inbox"
$MAILDIRMAKE "$HOME/rsync/mail/rss"
$MAILDIRMAKE "$HOME/rsync/mail/rss-lobsters"
$MAILDIRMAKE "$HOME/rsync/mail/rss-podcasts"
$MAILDIRMAKE "$HOME/rsync/mail/rss-youtube"
$MAILDIRMAKE "$HOME/rsync/mail/social"
$MAILDIRMAKE "$HOME/rsync/mail/state"
$MAILDIRMAKE "$HOME/rsync/mail/stores"

# Create empty .rsyncignore to bootstrap run of sync system
touch "$HOME/rsync/.rsyncignore"

# Create empty ~/.netrc if it not exists
touch $HOME/.netrc

# Create ~/.authinfo.gpg if not exists
touch $HOME/.authinfo.gpg

# Changing access rights
chmod -v 600 ~/.fdm.conf
chmod -v 600 ~/.mailfilter
chmod -v 600 ~/.msmtprc
chmod -v 600 ~/.netrc
chmod -v 600 ~/.authinfo.gpg

# Installing crontab
echo "Installing crontab"
crontab ./utils/crontab/crontab

# Restart dunst
pkill dunst

# Select target system and OS if not selected yet
if [ ! -f ~/.machine_id ]; then
    echo
    echo 'Machine:'
    echo
    echo '1) Gentoo (GNU/Linux) on Zalman'
    echo '2) FreeBSD on Thinkpad'
    echo
    read 'SELECTED_OS?Select machine: '

    case "$SELECTED_OS" in
        '1')
            echo "Gentoo on Zalman" > ~/.machine_id
            ;;
        '2')
            echo "FreeBSD on Thinkpad" > ~/.machine_id
            ;;
        '*')
            echo 'Wrong input!'
            exit 2
            ;;
    esac
fi

echo
echo 'Done!'
