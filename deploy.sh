#!/usr/bin/env bash


# Settings:
GITREPO_NAME="dotfiles"
CONFIG_DIRECTORIES="config_directories.txt"
PROTECTED_FILES="protected_files.txt"


# Are we in the directory with cloned dotfiles repository?
if [ "$(basename "$PWD")" != "$GITREPO_NAME" ] || [ ! -d ".git/" ]; then
    echo "Current directory IS NOT the directory with 'dotfiles' git repository!"
    exit 1
fi

# Are necessary configuration files exists?
if [ ! -e "$CONFIG_DIRECTORIES" ] || [ ! -e "$PROTECTED_FILES" ]; then
    echo "Configuration files: $CONFIG_DIRECTORIES, $PROTECTED_FILES - does not exists!"
    exit 2
fi

# Copying dotfiles to $HOME
cat "$CONFIG_DIRECTORIES" | while IFS= read -r directory
do
    while IFS= read -r -d '' from_file
    do
        to_file=$(echo "$from_file" | sed -r "s#$directory/(.*)#\1#g")
        if [ -e "$HOME/$to_file" ] && grep -q "$to_file" "$PROTECTED_FILES"; then
            echo "File $to_file already exists in $HOME and protected!"
            echo
            diff "$from_file" "$HOME/$to_file"
            echo
            echo "Skipping $from_file"
            echo
        else
            catalog=$(dirname "$HOME/$to_file")
            mkdir -p "$catalog"
            cp -v "$from_file" "$HOME/$to_file"
        fi
    done < <(find "$directory" -type f -print0)
done


# Making necessary (empty) directories for vim.
mkdir -pv "$HOME/.vim/swapfiles"
mkdir -pv "$HOME/.vim/undodir"
# Making directory for mutt.
mkdir -pv "$HOME/.mail/logs"
# Making directory for rsync
mkdir -pv "$HOME/rsync"
touch "$HOME/rsync/.rsyncignore"

# Changing access rights
chmod -v 600 ~/.fetchmailrc
chmod -v 600 ~/.msmtprc

echo
echo "Done!"

