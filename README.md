### About this repository

This repository contains different configuration files, which I have been writing since 2005.

### Dependencies

* abook
* aspell
* bash-completion
* ctags
* emacs
* fdm
* git
* jq
* lynx
* maildrop
* msmtp
* mutt
* rsync
* rtorrent
* stow
* sudo
* tmux
* vim
* wget
* xclip

Also, you may be need to install some fonts, like Terminus and Droid Sans Mono.

### Contents

* `cmd/` - shell-related configuration files.
* `utils/` - configuration files for different utilities, like vim or tmux.
* `noauto/` - different system configuration files, not for automatic installation. Described below.
* `deploy.sh` - main deployment script.

#### noauto/ contents

* `hosts` - `/etc/hosts` file. This is not a valid `hosts` file! You should review it and add useful entries to your `/etc/hosts` by hands!
* `st` - configuration file for st terminal emulator.

### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

Checkout next branch:
* `master` - for Linux (Gentoo)
* `freebsd-thinkpad` - for FreeBSD

Run *deploy.sh* script, which do the next:
* Make soft links from our catalog to the user $HOME catalog.
* Create necessary empty directories.
* Create mail directories.
* Set right access rights to some configuration files.

#### Vim plugins installation

After deployment do the next to install Vim plugins:
* First, install Vundle plugin: `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`.
* Second, in Vim execute `:BundleInstall command`.

#### Emacs plugins installation

Just run Emacs first time - it will install all necessary plugins itself

#### File synchronization

To work with file synchronization via rsync you need to have `sync` SSH-key with empty passphrase. This key should be added to remote server to rsync account into
`~/.ssh/authorized_keys`.

