### About this repository

This repository contains different configuration files, which I have been writing since 2005.

### Dependencies

* abook
* aspell (with aspell-ru dictionary)
* bc
* cabal
* cron
* ctags
* curl
* doas
* emacs
* fdm
* feh
* ghc
* git
* gpg
* i3
* imagemagick
* jq
* lame
* lynx
* maildrop
* make (gmake executable should be available)
* mc
* mplayer
* msmtp
* mutt
* newsboat
* pass
* pass-otp
* python3
* perl
* rsync
* rtorrent
* shred
* stow
* sxiv
* tmux (>= 3.2)
* urlview
* vim
* wget
* xclip
* yt-dlp
* zsh

Also, you may be need to install some fonts, like Terminus and Noto Mono.

GUI programs to install:
* audacious
* firefox
* gimp
* idea
* josm
* qmapshack
* rawtherapee
* telegram

If no `diff-highlight` binray in system — install it with `pip3 install diff-highlight`.

### Contents

* `cmd/` - shell-related configuration files.
* `utils/` - configuration files for different utilities, like vim or tmux.
* `noauto/` - different system configuration files, not for automatic installation. Described below.
* `deploy.sh` - main deployment script.

#### noauto/ contents

* `hosts` - `/etc/hosts` file. This is not a valid `hosts` file! You should review it and add useful entries to your `/etc/hosts` by hands!
* `st` - configuration file for st terminal emulator.

### Before install

To store sensitive data (passwords, etc) in the archive for the new machine -- use `store_sensitive_data.sh` script.

### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

Run *deploy.sh* script, which do the next:
* Make soft links from our catalog to the user $HOME catalog.
* Create necessary empty directories.
* Create mail directories.
* Set right access rights to some configuration files.

### After install

#### Haskell programs

Install next programs via `cabal install`:
* hasktags
* stylish-haskell

#### Emacs plugins compilation

Run `C-u 0 M-x byte-recompile-directory` to recomplile contents of `~/.emacs.d/plugins`.

#### File synchronization

To work with file synchronization via cloudsync you need to have `sync` SSH-key with empty passphrase. This key should be added to remote server to rsync account into
`~/.ssh/authorized_keys`.

#### Passwords

For using Mutt with GMail mailboxes you should specify mail server passwords in `~/.netrc`.

#### /etc/hosts

You should update your `/etc/hosts` with data from `noauto/hosts`.

#### doas setup

If you need to control brightness of display when starting X-server — add next line to `doas.conf`:

```
permit nopass drag0n as root cmd tee args /sys/class/backlight/intel_backlight/brightness
```

#### Import GPG keys

Use this commands:
```
gpg --import pub.key
gpg --import priv.key
```

Then call `gpg --edit-key <key-id>` and set trust level to 5 via command `trust`. Quit gpg console with `quit` command.

#### Weather forecasts

Add your OpenWeatherMap API key to `~/.openweathermap` file.

