### About this repository

This repository contains different configuration files, which I
have been writing since 2005.


### Dependencies

List of programs, which using by scripts inside the bin/ directory:
* xrandr
* dialog
* dmenu

List of programs, which using these configuration files or used by these files:
* mplayer
* sudo
* feh
* bash-completion
* screen
* exuberant-ctags
* git
* vim (and gvim too)
* Xorg
* rtorrent
* google-chrome or chromium (by vim)
* urxvt
* setxkbmap
* xsetroot
* i3wm

These lists do not include usual programs like grep or rm.

Also, you may be need to install some fonts, like Terminus and Droid Sans Mono.

List of Vim dependencies you can find in .vimrc file. Look at this file before start use Vim!


### Contents

* `.vim`
  * `mproj` - templates for different projects
    * `c` - template for C project
    * `latex-beamer` - template for LaTeX presentation
    * `latex-report` - template for LaTeX report
  * `syntax` - old syntax files. I just like it
* `.aliases` - useful bash aliases
* `.bash_login`
* `.bashrc`
* `.ctags` - configuration file for exuberant-ctags. Adds support for
TeX, Markdown files and Makefiles. Without it file you cannot use vim's plugin
TagList with above filetypes
* `.gitconfig` - possibly, you should remove it or rewrite if you use Git
* `.inputrc` - enables useful history search. You could type only part of command
and with 'Up' and 'Down' buttons you will search for commands which matches only
with typed text
* `.profile` - important shell variables, like EDITOR
* `.rtorrent.rc` - configuration file for rtorrent
* `.screenrc`
* `.vimrc`
* `.xdefaults` - fonts and urxvt settings. Includes urxvt color settings
* `.xinitrc` - command which will be executing after X server will start. Includes
commands which install your wallpaper on the desktop, setup keyboard language switch ant so on
* `bin` - different scripts, which make life easier
  * `displays.sh` - recofigure Xorg for two-monitor configuration
  on the fly. It worked on my old notebook with old tube monitor 3-4
  years ago
  * `goodmenu.sh` - displays dmenu with GUI programs such as google-chrome
  or gvim
* `deploy.sh` - installs this configuration files in the your system. Read **Install** section for
more information


### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

After that run *deploy.sh* script, which just create symlinks in $HOME directory to
these configuration files. If $HOME contains some matching configuration files -
script warn you and will not rewrite these files.
