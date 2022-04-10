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

# Clearing precompiled Emacs-Lisp files if exists
find ~/.emacs.d/plugins/haskell-mode/ -type f -exec rm {} \;

# Copying dotfiles to $HOME
export STOW_DIR=./utils
stow abook emacs git i3wm mplayer mutt newsboat rtorrent ssh tmux vim zathura

# Making necessary (empty) directories
mkdir -pv "$HOME/secure/.emacs.d"
mkdir -pv "$HOME/secure/.vim/swapfiles"
mkdir -pv "$HOME/secure/.vim/undodir"
mkdir -pv "$HOME/rsync/mail"
mkdir -pv "$HOME/rsync/mail/logs"

if [ -x /usr/bin/maildirmake ]; then
    MAILDIRMAKE="/usr/bin/maildirmake"
elif [ -x /usr/local/bin/maildrop-maildirmake ]; then
    MAILDIRMAKE="/usr/local/bin/maildrop-maildirmake"
fi
$MAILDIRMAKE "$HOME/rsync/mail/banks"
$MAILDIRMAKE "$HOME/rsync/mail/checks"
$MAILDIRMAKE "$HOME/rsync/mail/default"
$MAILDIRMAKE "$HOME/rsync/mail/haskell"
$MAILDIRMAKE "$HOME/rsync/mail/maillists"
$MAILDIRMAKE "$HOME/rsync/mail/social"
$MAILDIRMAKE "$HOME/rsync/mail/state"
$MAILDIRMAKE "$HOME/rsync/mail/stores"

# Create empty .rsyncignore to bootstrap run of sync system
touch "$HOME/rsync/.rsyncignore"

# Create empty ~/.netrc if it not exists
touch $HOME/secure/.netrc
ln -s "$HOME/secure/.netrc" "$HOME/.netrc"

# Create empty OpenWeatherMap API key file
touch $HOME/secure/.openweathermap
ln -s "$HOME/secure/.openweathermap" "$HOME/.openweathermap"

# Changing access rights
chmod -v 600 ~/.fdm.conf
chmod -v 600 ~/.mailfilter
chmod -v 600 ~/.msmtprc
chmod -v 600 ~/.netrc ~/secure/.netrc

# Installing crontab
echo "Installing crontab"
crontab ./utils/crontab/crontab

# Compiling emacs plugins
echo "Compiling haskell-mode plugin"
cd ~/.emacs.d/plugins/haskell-mode && gmake > /dev/null

# Select target system if not selected yet
if [ ! -f ~/.gentoo ] && \
    [ ! -f ~/.debian ]; then
    echo
    echo 'OS:'
    echo
    echo 'g) Gentoo (GNU/Linux)'
    echo 'd) Debian'
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
        '*')
            echo 'Wrong input! Cannot determine OS - system may work incorrectly!'
            exit 2
            ;;
    esac
fi

# Select target machine if not selected yet
if [ ! -f ~/.zalman ] && \
    [ ! -f ~/.thinkpad ]; then
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

echo
echo 'Done!'

