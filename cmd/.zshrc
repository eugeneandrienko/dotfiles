# Settings for emacs mode
bindkey -e
export KEYTIMEOUT=1
bindkey "^[[1~" beginning-of-line # Home key
bindkey "^[[4~" end-of-line # End key
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
export LISTMAX=9999

setopt appendhistory autocd extendedglob no_nomatch notify
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt no_auto_remove_slash
setopt glob_star_short glob_dots
setopt auto_pushd pushd_ignore_dups
setopt rm_star_silent
setopt pipe_fail
unsetopt beep

bindkey '^[[Z' reverse-menu-complete

zstyle :compinstall filename '/home/drag0n/.zshrc'
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
autoload -Uz compinit
compinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
# Use "Delete" key as I like:
bindkey '^[[3~' delete-char
bindkey -a '^[[3~' delete-char

# Functions setup:
fpath+=~/.zshfunctions
autoload -z video2gif
autoload -z video_rotate
autoload -z videos_rotate
autoload -z cloudsync && cloudsync && \
    autoload -z cloudsync_force_local && \
    autoload -z cloudsync_force_remote
autoload -z scanphoto_10x15
autoload -z scana4
autoload -z hotkeys && hotkeys
autoload -z main_machine
autoload -z png2jpg
autoload -z jpg2timelapse
autoload -z backup_data && backup_data
autoload -z drivesync && drivesync
autoload -z phonesync
autoload -z emacs

if [ -e ~/.aliases ]; then
    . ~/.aliases
fi

# Prompt setup:
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' %F{cyan}(%b)%f'
zstyle ':vcs_info:*' enable git

function zle-line-init zle-keymap-select {
    mode_vi=${${KEYMAP/vicmd/%B+%b}/(main|viins)/%B%#%b}
    PS1="%F{green}%2~%f\$vcs_info_msg_0_ ${mode_vi} "
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
precmd() { printf "\a\033]2;\033\\" }

if [ -z $MC_TMPDIR ]; then
    RPROMPT="%F{blue}[%D{%H:%M:%S}]%f %n@%m"
else
    # To properly display shell prompt without RPROMPT in mc
    RPROMPT=""
fi
export RPROMPT

mailpath=(
    ~/rsync/mail/default"?New mail in =default"
    ~/rsync/mail/maillists"?New mail in =maillists"
    ~/rsync/mail/state"?New mail in =state"
    ~/rsync/mail/stores"?New mail in =stores"
)

# Remove unnecessary catalogs:
if [ -d "$HOME/Desktop" ] || [ -d "$HOME/Downloads" ]; then
    rm -rf ~/Desktop ~/Downloads
fi

if [ -e ~/.userconfig ]; then
    . ~/.userconfig
fi
