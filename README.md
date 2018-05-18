### About this repository

This repository contains different configuration files, which I
have been writing since 2005.

### Dependencies

* cmus
* ctags
* htop
* git
* sudo
* tmux
* vim
* wget
* xclip

Also, you may be need to install some fonts, like Terminus and Droid Sans Mono.

### Contents

* `bin/` - useful utilites, which I imported as submodules.
* `cmd/` - shell-related configuration files.
* `utils/` - configuration files for different utilities, like vim or tmux.
* `config_directories.txt` - list of catalogs with our dotfiles - one catalog for one program's configs.
* `deploy.sh` - main deployment script.
* `deploy.py` - Python 3 program, which copies dotfiles from our catalogs to user $HOME catalog.

### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

You need to have a Python 3 on your machine, to deploy dotfiles!

Run *deploy.sh* script, which do the next:
* Copy dotfiles from our catalog to the user $HOME catalog.
* Checkout repositories with sources of some useful small binaries.
* Build these binaries and install it to $HOME/.bin/

#### Vim plugins installation

After deployment do the next to install Vim plugins:
* First, install Vundle plugin: `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`.
* Second, in Vim execute `:BundleInstall command`.

