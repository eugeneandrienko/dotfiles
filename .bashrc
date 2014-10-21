test -f /etc/profile.d/bash-completion.sh && source /etc/profile.d/bash-completion.sh

set -o emacs

shopt -s histappend
shopt -s cmdhist
shopt -s cdspell
shopt -s autocd
shopt -s globstar

PROMPT_COMMAND=`history -a`

LIGHTWHITE="\[\033[1;37m\]"
WHITE="\[\033[0;37m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[1;36m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"

if [ "$UID" = "0" ]; then
    SPEC_SYMBOL="$RED#"
    ADOG=$RED@$WHITE
else
    SPEC_SYMBOL="$WHITE\$"
    ADOG=$CYAN@$WHITE
fi

PS1="\u$ADOG\h $GREEN\w$WHITE\n$SPEC_SYMBOL "
export PS1

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
    SCREEN_BIN="/usr/local/bin/screen"
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
