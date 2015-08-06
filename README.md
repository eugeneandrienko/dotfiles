### About this repository

This repository contains different configuration files, which I
have been writing since 2005.


### Dependencies

Look to the `requirements.txt` file.

Also, you may be need to install some fonts, like Terminus and Droid Sans Mono.

List of Vim dependencies you can find in .vimrc file. Look at this file before starting to use Vim!


### Contents

* `cmd` - shell-related configuration files.
* `utils` - configuration files for different utilities, like vim or tmux.

### Install

Clone this repository to some suitable directory.

You **mustn't** clone it to your `~` directory!

You need to have a Python 3 on your machine, to deploy dotfiles!

Run *deploy.sh* script, which just create symlinks in $HOME directory to these configuration files. If $HOME contains some matching configuration files - script warn you and create backups for these files.

