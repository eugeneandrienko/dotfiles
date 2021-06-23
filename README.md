### About this repository

This repository contains different configuration files, which I have been writing since 2005.

### Dependencies

* abook
* aspell
* ctags
* doas
* emacs
* fdm
* feh
* git
* jq
* lynx
* maildrop
* msmtp
* mutt
* rsync
* rtorrent
* stow
* sxiv
* tmux (>= 3.2)
* urlview
* vim
* wget
* xclip
* zsh

Also, you may be need to install some fonts, like Terminus and Droid Sans Mono.

### Contents

* `cmd/` - shell-related configuration files.
* `utils/` - configuration files for different utilities, like vim or tmux.
* `noauto/` - different system configuration files, not for automatic installation. Described below.
* `deploy.sh` - main deployment script.

#### noauto/ contents

* `hosts` - `/etc/hosts` file. This is not a valid `hosts` file! You should review it and add useful entries to your `/etc/hosts` by hands!
* `st` - configuration file for st terminal emulator.

### Before install

In the `$HOME` should exists `secure/` catalog which should be encrypted.

#### Encryption in FreeBSD

```
pefs addchain -a aes256 -fZ /home/secure
pefs mount /home/secure /home/secure
pefs addkey -a aes256 -c /home/secure
pefs umount /home/secure
```

To open encrypted directory use `unsecure` alias, to encrypt directory again - `secure` alias.

### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

Run *deploy.sh* script, which do the next:
* Make soft links from our catalog to the user $HOME catalog.
* Create necessary empty directories.
* Create mail directories.
* Set right access rights to some configuration files.

#### Emacs plugins compilation

Run `C-u 0 M-x byte-recompile-directory` to recomplile contents of `~/.emacs.d/plugins`.

#### File synchronization

To work with file synchronization via rsync you need to have `sync` SSH-key with empty passphrase. This key should be added to remote server to rsync account into
`~/.ssh/authorized_keys`.

#### Passwords

For using Mutt with GMail mailboxes you should specify mail server passwords in `~/secure/.netrc`.

#### /etc/hosts

You should update your `/etc/hosts` with data from `noauto/hosts`.

#### doas setup

If you need to control brightness of display when starting X-server — add next line to `doas.conf`:

```
permit nopass  drag0n as root cmd sysctl args hw.acpi.video.lcd0.brightness=70
```

