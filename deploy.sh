#!/usr/bin/env sh

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
stow abook emacs git i3wm mplayer mutt rtorrent tmux vim

# Making necessary (empty) directories
mkdir -pv "$HOME/.vim/swapfiles"
mkdir -pv "$HOME/.vim/undodir"
mkdir -pv "$HOME/rsync/mail"
mkdir -pv "$HOME/rsync/mail/logs"
maildirmake "$HOME/rsync/mail/banks"
maildirmake "$HOME/rsync/mail/checks"
maildirmake "$HOME/rsync/mail/default"
maildirmake "$HOME/rsync/mail/haskell"
maildirmake "$HOME/rsync/mail/maillists"
maildirmake "$HOME/rsync/mail/social"
maildirmake "$HOME/rsync/mail/state"
maildirmake "$HOME/rsync/mail/stores"

# Create empty .rsyncignore to bootstrap run of sync system
touch "$HOME/rsync/.rsyncignore"

# Changing access rights
chmod -v 600 ~/.fdm.conf
chmod -v 600 ~/.mailfilter
chmod -v 600 ~/.msmtprc
chmod -v 600 ~/.netrc

# Installing right crontab
echo "Installing crontab"
crontab ./utils/crontab/crontab

echo
echo "Done!"

