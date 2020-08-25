#!/bin/bash


# Settings:
GITREPO_NAME="dotfiles"


# Are we in the directory with cloned dotfiles repository?
if [ "$(basename "$PWD")" != "$GITREPO_NAME" ] || [ ! -d ".git/" ]; then
    echo "Current directory IS NOT the directory with 'dotfiles' git repository!"
    exit 1
fi


# Are we have Python3 installed?
if ! python3 -c 'quit()'; then
    echo "You do not have Python 3 on the machine!"
    echo "Install Python 3 first."
    exit 1
fi

if ! python3 ./deploy.py --deploy; then
    exit 1
fi
echo "Done!"
echo


# Making necessary (empty) directories for vim.
mkdir -pv "$HOME/.vim/swapfiles"
mkdir -pv "$HOME/.vim/undodir"
# Making directory for mutt.
mkdir -pv "$HOME/.mail/logs"

# Changing access rights
chmod -v 600 ~/.fetchmailrc
chmod -v 600 ~/.msmtprc

# Warn user what he need to change some files:
echo "Place valid data instead of placeholders in next files:"
echo "~/.fetchmailrc"
echo "~/.msmtprc"
echo "~/.signature"

echo
echo "Almost done!"

