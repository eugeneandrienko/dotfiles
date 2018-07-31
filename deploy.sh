#!/usr/local/bin/bash


# Settings:
GITREPO_NAME="dotfiles"


# Are we in the directory with cloned dotfiles repository?
ls -aF | grep -q '\.git/'
DOTGIT_NOT_PRESENT=$?
if [ `basename $PWD` != $GITREPO_NAME ] || [ $DOTGIT_NOT_PRESENT -ne 0 ]; then
    echo "Current directory IS NOT the directory with 'dotfiles' git repository!"
    exit 1
fi


# Are we have Python3 installed?
python3 -c 'quit()'
if [ "$?" -ne "0" ]; then
    echo "You do not have Python 3 on the machine!"
    echo "Install Python 3 first."
    exit 1
fi

git submodule init
git submodule update
python3 ./deploy.py --deploy
if [ "$?" -ne "0" ]; then
    exit 1
fi
echo "Done!"
echo


# Making necessary (empty) directories for vim.
mkdir -pv $HOME/.vim/swapfiles
mkdir -pv $HOME/.vim/undodir

# Update login.conf binary config
cap_mkdb -f ~/.login_conf ~/.login_conf

echo "Done!"

