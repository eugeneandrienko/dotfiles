#!/bin/bash


# Settings:

GITREPO_NAME="dotfiles"
# Ignored files and catalogs (in ls -F format), separated by colon
IGNORED_FILES=".git/:README.md:deploy.sh*:.gitignore"



# Are we in the directory with cloned dotfiles repository?

ls -aF | grep -q '\.git/'
DOTGIT_NOT_PRESENT=$?
if [ `basename $PWD` != $GITREPO_NAME ] || [ $DOTGIT_NOT_PRESENT -ne 0 ]; then
    echo "Current directory IS NOT the directory with 'dotfiles' git repository!"
    exit 1
fi


echo "Deploying configuration files to the your home directory..."
echo


FILELIST=`ls -AF`
for repo_file in $FILELIST; do
    echo $IGNORED_FILES | tr ':' '\n' | grep -q $repo_file
    FILE_NOT_IGNORED=$?
    if [ $FILE_NOT_IGNORED -eq 1 ]; then
        repo_file=`basename $repo_file`
        if [ -e "$HOME/$repo_file" ]; then
            echo "~/$repo_file already exists in your HOME directory!"
            continue
        fi
        ln -s $PWD/$repo_file $HOME/$repo_file
        if [ $? -ne 0 ]; then
            echo "Cannot create symlink to $repo_file in your HOME directory!"
        else
            echo "$repo_file -> ~/$repo_file"
        fi
    fi
done
echo

mkdir -pv $HOME/.vim/swapfiles
mkdir -pv $HOME/.vim/undodir

echo
echo "Done!"

