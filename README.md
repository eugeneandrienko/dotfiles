### About this repository

This repository contains different configuration files, which I
have been writing since 2005.

### Dependencies

* ctags
* git
* lynx
* fetchmail
* procmail
* msmtp
* mutt
* sudo
* tmux
* vim
* wget
* xclip
* rtorrent
* aspell

Also, you may be need to install some fonts, like Terminus and Droid Sans Mono.

### Contents

* `cmd/` - shell-related configuration files.
* `utils/` - configuration files for different utilities, like vim or tmux.
* `noauto/` - different system configuration files, not for automatic installation. Described below.
* `config_directories.txt` - list of catalogs with our dotfiles - one catalog for one program's configs.
* `deploy.sh` - main deployment script.
* `deploy.py` - Python 3 program, which copies dotfiles from our catalogs to user $HOME catalog.

#### noauto/ contents

* `hosts` - `/etc/hosts` file. This is not a valid `hosts` file! You should review it and add useful entries to your `/etc/hosts` by hands!
* `st` - configuration file for st terminal emulator.

### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

You need to have a Python 3 on your machine, to deploy dotfiles!

Checkout next branch:
* `master` - for Linux (Gentoo).

Run *deploy.sh* script, which do the next:
* Copy dotfiles from our catalog to the user $HOME catalog.

#### Vim plugins installation

After deployment do the next to install Vim plugins:
* First, install Vundle plugin: `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`.
* Second, in Vim execute `:BundleInstall command`.

