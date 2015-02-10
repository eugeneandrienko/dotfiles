### About this repository

This repository contains different configuration files, which I
have been writing since 2005.


### Dependencies

List of programs, which using by scripts inside the bin/ directory:
* dialog
* dmenu
* xrandr

List of programs, which using these configuration files or used by these files:
* bash-completion
* exuberant-ctags
* feh
* git
* google-chrome or chromium (used by vim)
* i3lock-wrapper
* i3wm
* mocp
* mplayer
* rtorrent
* screen
* setxkbmap
* sudo
* task
* transset-df
* vim (and gvim too)
* vimpager
* urxvt
* xcompmgr
* Xorg
* xsetroot

These lists do not include usual programs like grep or rm.

Also, you may be need to install some fonts, like Terminus and Droid Sans Mono.

List of Vim dependencies you can find in .vimrc file. Look at this file before start use Vim!


### Contents

* `.aliases` - useful bash aliases
* `.bashrc`
* `bin/displays.sh` - recofigure Xorg for two-monitor configuration
on the fly. It worked on my old notebook with old tube monitor 3-4
years ago
* `bin/goodmenu.sh` - displays dmenu with GUI programs such as google-chrome
or gvim
* `.ctags` - configuration file for exuberant-ctags. Adds support for
TeX, Markdown files and Makefiles. Without it file you cannot use vim's plugin
TagList with above filetypes
* `deploy.sh` - installs this configuration files in the your system. Read **Install** section for
more information
* `.gitconfig` - possibly, you should remove it or rewrite if you use Git
* `.i3/config` - configuration file for i3wm
* `.i3status.conf` - configuration file for i3bar
* `.inputrc` - enables useful history search. You could type only part of command
and with 'Up' and 'Down' buttons you will search for commands which matches only
with typed text
* `.mcabber/mcabberrc` - configuration file for mcabber
* `.moc/config` - configuration file for mocp
* `.moc/themes/orpheus` - theme for mocp
* `.profile` - important shell variables, like EDITOR
* `.rtorrent.rc` - configuration file for rtorrent
* `.screenrc` - configuration file for screen
* `.taskrc` - configuraton file for task (TaskWarrior client)
* `.vim/mproj/c/` - template for C projects
* `.vim/mproj/latex-beamer/` - template for LaTeX presentation
* `.vim/mproj/latex-report/` - template for LaTeX report
* `.vimrc` - configuration file for Vim
* `.xdefaults` - fonts and urxvt settings. Includes urxvt color settings
* `.xinitrc` - command which will be executing after X server will start. Includes
commands which install your wallpaper on the desktop, setup keyboard language switch ant so on


### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

After that run *deploy.sh* script, which just create symlinks in $HOME directory to
these configuration files. If $HOME contains some matching configuration files -
script warn you and will not rewrite these files.
