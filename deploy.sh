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
stow cmd

# Copying dotfiles to $HOME
export STOW_DIR=./utils
stow abook emacs git i3wm mplayer mutt rtorrent tmux vim
if [ ! -f "~/.fetchmailrc" ]; then
    cp -v "$STOW_DIR"/mutt/.fetchmailrc ~
fi
if [ ! -f "~/.msmtprc" ]; then
    cp -v "$STOW_DIR"/mutt/.msmtprc ~
fi

# Making necessary (empty) directories
mkdir -pv "$HOME/.vim/swapfiles"
mkdir -pv "$HOME/.vim/undodir"
mkdir -pv "$HOME/.mail/logs"
mkdir -pv "$HOME/rsync"

# Create empty .rsyncignore to bootstrap run of sync system
touch "$HOME/rsync/.rsyncignore"

# Changing access rights
chmod -v 600 ~/.fetchmailrc
chmod -v 600 ~/.msmtprc

echo
echo "Done!"

