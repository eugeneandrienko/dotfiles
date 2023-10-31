# Settings for emacs mode
bindkey -e
bindkey "^[[1~" beginning-of-line # Home key
bindkey "^[[4~" end-of-line # End key
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Zsh-specific options:
setopt appendhistory autocd extendedglob no_nomatch notify
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
setopt no_auto_remove_slash
setopt glob_star_short glob_dots
setopt auto_pushd pushd_ignore_dups
setopt rm_star_silent
setopt pipe_fail
setopt auto_param_slash
unsetopt beep

# Completion settings:
bindkey '^[[Z' reverse-menu-complete

autoload -Uz compinit; compinit
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zcompcache
zstyle ':completion:*' menu select=long
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true

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
autoload -z cloudsync
autoload -z cloudsync_force_local
autoload -z cloudsync_force_remote
autoload -z scanphoto_10x15
autoload -z scana4
autoload -z png2jpg
autoload -z jpg2timelapse
autoload -z backup_data
autoload -z drivesync
autoload -z drivesync_force_drive
autoload -z drivesync_force_local
autoload -z phonesync
autoload -z emacs
autoload -z ydl_channel_id
autoload -z youtube
autoload -z create_enc_file
autoload -z rename_photos_by_exif

# Hotkeys helpers:
fpath+=~/.hotkeys
autoload -z hotkeys-emacs
autoload -z hotkeys-emacs-java
autoload -z hotkeys-emacs-latex
autoload -z hotkeys-emacs-magit
autoload -z hotkeys-emacs-org
autoload -z hotkeys-i3wm
autoload -z hotkeys-mc
autoload -z hotkeys-mutt
autoload -z hotkeys-rtorrent
autoload -z hotkeys-tmux
autoload -z hotkeys-vim
autoload -z hotkeys-zathura

# Aliases:
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
    RPROMPT="%F{blue}[%D{%H:%M:%S}]%f"
else
    # To properly display shell prompt without RPROMPT in mc
    RPROMPT=""
fi
export RPROMPT

# Maildirs:
mailpath=(
    ~/rsync/mail/default"?New mail in =default"
    ~/rsync/mail/infrastructure"?New mail in =infrastructure"
    ~/rsync/mail/maillists"?New mail in =maillists"
    ~/rsync/mail/rss"?New mail in =rss"
    ~/rsync/mail/rss-podcasts"?New mail in =rss-podcasts"
    ~/rsync/mail/rss-youtube"?New mail in =rss-youtube"
    ~/rsync/mail/social"?New mail in =social"
    ~/rsync/mail/state"?New mail in =state"
    ~/rsync/mail/stores"?New mail in =stores"
)

# Remove unnecessary catalogs:
if [ -d "$HOME/Desktop" ] || [ -d "$HOME/Downloads" ]; then
    rm -rf ~/Desktop ~/Downloads
fi

# Specific user config:
if [ -e ~/.userconfig ]; then
    . ~/.userconfig
fi

