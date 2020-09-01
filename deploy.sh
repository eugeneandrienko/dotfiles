#!/bin/bash


# Settings:
GITREPO_NAME="dotfiles"
CONFIG_DIRECTORIES_FILE="config_directories.txt"


# Are we in the directory with cloned dotfiles repository?
if [ "$(basename "$PWD")" != "$GITREPO_NAME" ] || [ ! -d ".git/" ]; then
    echo "Current directory IS NOT the directory with 'dotfiles' git repository!"
    exit 1
fi


# Copying dotfiles to $HOME
for directory in $(cat "$CONFIG_DIRECTORIES_FILE"); do
    cp -Rv $directory/ ~
done


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

echo
echo "Almost done!"

