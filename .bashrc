# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source ~/.profile

set -o vi

shopt -s histappend
shopt -s cmdhist
shopt -s cdspell
shopt -s autocd
shopt -s globstar
shopt -s checkwinsize

LIGHTWHITE="\[\033[1;37m\]"
WHITE="\[\033[0;37m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[1;36m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"

SPEC_COLOR="$WHITE"
ADOG=$CYAN@$WHITE

PS1PROMPT="$WHITE[\u$ADOG\h] $GREEN\w$WHITE\n$SPEC_COLOR\$ "

function retval {
    if [ $? -eq 0 ]; then
        PS1="$GREEN$? "
    else
        PS1="$RED$? "
    fi
    PS1+=$PS1PROMPT
    PS1+=$CYAN
}
PROMPT_COMMAND='retval'
export PROMPT_COMMAND
export PS1

# show command output in normal color
trap 'echo -ne "\e[0m"' DEBUG

PS2="$YELLOW> $WHITE"
export PS2

HISTCONTROL=ignoredups
export HISTCONTROL

HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"
export HISTTIMEFORMAT

# press Ctrl+D twice for logout
IGNOREEOF=1
export IGNOREEOF

# Do not write command that starts with a space to history.
HISTCONTROL=ignorespace
export HISTCONTROL

#. ~/.profile

function screen {
    SCREEN_BIN="/usr/bin/screen"
    if [ ! -n "$1" ]; then
        $SCREEN_BIN -ls
    else
        $SCREEN_BIN -ls | grep -q "\.\<$1\>"
        if [ "$?" -eq "0" ]; then
            $SCREEN_BIN -dr "$1"
        else
            $SCREEN_BIN -S "$1"
        fi
    fi
}

if [ -e ~/.aliases ]; then
    . ~/.aliases
fi
