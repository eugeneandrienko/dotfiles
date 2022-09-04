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

# Clearing precompiled Emacs-Lisp files if exists
find ~/.emacs.d/plugins/haskell-mode/ -type f -exec rm {} \;

# Copying dotfiles to $HOME
export STOW_DIR=./utils
stow abook emacs git gnupg i3wm mc mplayer mutt newsboat rtorrent ssh tmux vim zathura

# Making necessary (empty) directories
mkdir -pv "$HOME/.vim/swapfiles"
mkdir -pv "$HOME/.vim/undodir"
mkdir -pv "$HOME/rsync/filez"
mkdir -pv "$HOME/rsync/mail"
mkdir -pv "$HOME/rsync/mail/logs"

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
$MAILDIRMAKE "$HOME/rsync/mail/maillists"
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

# Select target system if not selected yet
if [ ! -f ~/.gentoo ] && \
    [ ! -f ~/.debian ] && \
    [ ! -d ~/.termux ]; then
    echo
    echo 'OS:'
    echo
    echo 'g) Gentoo (GNU/Linux)'
    echo 'd) Debian'
    echo 't) Termux'
    echo
    read 'SELECTED_OS?Select OS: '

    case "$SELECTED_OS" in
        'g')
            touch ~/.gentoo
            echo 'Selected Gentoo (GNU/Linux)'
            ;;
        'd')
            touch ~/.debian
            echo 'Selected Debian'
            ;;
        't')
            touch ~/.termux
            echo 'Selected Termux'
            ;;
        '*')
            echo 'Wrong input! Cannot determine OS - system may work incorrectly!'
            exit 2
            ;;
    esac
fi

# Select target machine if not selected yet
if [ ! -f ~/.zalman ] && \
    [ ! -f ~/.thinkpad ] && \
    [ ! -d ~/.termux ]; then
    echo
    echo 'Machine:'
    echo
    echo 'z) Zalman'
    echo 't) Thinkpad'
    echo
    read 'SELECTED_MACHINE?Select machine: '

    case "$SELECTED_MACHINE" in
        'z')
            touch ~/.zalman
            echo 'Selected Zalman'
            ;;
        't')
            touch ~/.thinkpad
            echo 'Selected Thinkpad'
            ;;
        '*')
            echo 'Wrong input! Cannot determine machine - system may work incorrectly!'
            exit 3
            ;;
    esac
fi

# Select "main machine" status
if [ ! -f ~/.main-machine ] && \
    [ ! -f ~/.not-main-machine ]; then
    echo
    echo '"Main machine" will retrieve mail from mail servers automatically'
    echo
    read 'ANSWER?Is this main machine? [y/n]: '
    echo
    if [ "$ANSWER" = "y" ]; then
        touch ~/.main-machine
        echo 'This is main machine'
    else
        touch ~/.not-main-machine
        echo 'This is NOT main machine'
    fi
fi

# Some fixes for Termux
if [ -d ~/.termux ]; then
    sed -ri 's!skin=/home/drag0n.*!skin=/home/.config/mc/gray-green-purple256.ini!g' ~/.config/mc/ini
    rm -rf ~/.emacs.d/plugins/haskell-mode/
    sed -ri '/haskell/d' ~/.emacs
fi

echo
echo 'Done!'

