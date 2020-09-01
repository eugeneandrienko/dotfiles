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

set -o emacs

shopt -s histappend
shopt -s cmdhist
shopt -s cdspell
shopt -s autocd
shopt -s globstar
shopt -s checkwinsize

# show command output in normal color
trap 'echo -ne "\e[0m"' DEBUG

if [ -e ~/.env ]; then
    . ~/.env
fi

if [ -e ~/.aliases ]; then
    . ~/.aliases
fi

if [ -e ~/.prompt ]; then
    . ~/.prompt
fi

if [ -e ~/.functions ]; then
    . ~/.functions
fi

if [ -e ~/.hotkeys ]; then
    . ~/.hotkeys
fi

