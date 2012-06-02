# exported variables is specify for bash, because it here and 
# not in ~/.profile
# Start the Emacs server
if [ "`pgrep emacs | wc -l`" -eq "0" ]; then
    echo "Starting the Emacs server..."
    emacs --daemon
fi
#test -f /etc/profile.d/bash-completion.sh && source /etc/profile.d/bash-completion.sh
#. /etc/bash_completion
[ -r /usr/share/bash-completion/bash_completion   ] && \
. /usr/share/bash-completion/bash_completion

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
#PS1="$ADOG\h $CYAN\W$SPEC_SYMBOL$GREEN "
PS1="\u$ADOG\h $GREEN\w$WHITE\n$SPEC_SYMBOL "
export PS1
PS2="$YELLOW> $WHITE"
export PS2
HISTCONTROL=ignoredups
export HISTCONTROL
HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"
export HISTTIMEFORMAT
# Ctrl+D дважды для logout 
IGNOREEOF=1
export IGNOREEOF
# Не записываем в history команду с пробелом в начале
HISTCONTROL=ignorespace
export HISTCONTROL
#. ~/.profile
#function command_not_found_handle {
#EXECUTED_CMD=`history | tail -n 1 | awk '{$1 = ""; print $0}' | colrm 1 1 | sed -r 's/[0-9][0-9]\.[0-9][0-9]\.[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] (.*)/\1/g'`
#    echo -e "ОноТолЕй СъеЛ $EXECUTED_CMD. ПЫщЬ пЫщЬ!!!111"
#    echo -e "Воены УПЧК следят за тобой "'$USERNAME'
#}
function screen {
    SCREEN_BIN="/usr/bin/screen"
    if [ ! -n "$1" ]; then
        $SCREEN_BIN -ls
    else
        $SCREEN_BIN -ls | grep -q "\.\<$1\>"
        if [ "$?" -eq "0" ]; then
            $SCREEN_BIN -dr "$1"
        elif [ "$1" == "main" ]; then
            $SCREEN_BIN -S "$1" -c ~/.screenrc-main
        else
            $SCREEN_BIN -S "$1"
        fi
    fi
}
function g {
    if [ "$*" = "" ]; then
        echo "Usage: g [search string]"
    elif env | grep -q DISPLAY; then
        YOUR_BROWSER=google-chrome
        # you must escape your backslashes and exclamation marks and ampersands and brackets and semicolons =))
        SEARCHSTR=`echo "$*" | sed 's/+/%2B/g' | sed 's/&/%26/g' | sed 's/ /+/g'`
        env $YOUR_BROWSER "http://www.google.ru/search?sourceid=chrome&ie=UTF-8&q=""$SEARCHSTR" # &>/dev/null &
    fi
}
#fortune h_d_forts
#if [ -f /usr/bin/grc ]; then
#  alias grca="grc --colour=auto"
#  for c in ping traceroute make diff last cvs netstat uptime vmstat iostat mount uname route lsmod whereis ; do
#    alias ${c}="grca ${c}"
#  done
#  
#  alias ccal="grca cal"
#fi
if [ -e ~/.aliases ]; then
    . ~/.aliases
fi
#check - do we need update hg repo (dotfiles)
#HGSTATUS=`hg status -q`
#if [ "$HGSTATUS" == "" ]; then
#    echo "http://bitbucket.org/h0rr0rr_drag0n/dotfiles no difference to the local repository"
#else
#    echo -e "\e[01;31mhttp://bitbucket.org/h0rr0rr_drag0n/dotfiles varies with the local repository!!!\e[0;37m"
#    echo "--------------------------------------------------------"
#    hg status -q
#    echo "Commit? [y/n]"
#    read ANSWER
#    if [ "$ANSWER" == "y" ]; then
#        hg commit
#        hg push
#    fi
#fi

#Start the Dropbox
#~/.bin/start_dropbox.sh

#start halevt
#ps -e | grep -q halevt
#if [ "$?" -ne "0" ]; then
#    halevt -c /home/drag0n/.halevt
#fi

function d3ssh {
    #ssh -p 666 -i /home/drag0n/.ssh/id_rsa_d3 drag0n@"${1// */}"
    ssh -p 666 -i /home/drag0n/.ssh/id_rsa_d3 drag0n@77.234.203.163
}
