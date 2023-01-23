LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

EDITOR="emacs.sh";
export EDITOR

LESS="-R";              export LESS
LC_MESSAGES="C";        export LC_MESSAGES
LC_ALL="en_US.utf8";    export LC_ALL

# Set quoting style for ls here, since GNU/Linux coreutils
# maintainers break the compatibility with decades of
# de facto standards
QUOTING_STYLE=literal
export QUOTING_STYLE


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

# Don't clear the screen after quitting a manual page
export MANPAGER='less -RFX'

# Don't clear the screen after quitting pager
export PAGER='less -RFX'

export LESS=RFXj2
export LESS=${LESS}"Ps?f%f .?m(%i/%m) .%lt-%lb?L/%L. [%bB?B/%B.]?B %pB\%.?x N\:%x.%t"

export MAILDIR=$HOME/rsync/mail

# For pass
export PASSWORD_STORE_ENABLE_EXTENSIONS="true"
export PASSWORD_STORE_DIR="$HOME/rsync/filez/pass"

# For GPG signing Git commits:
export GPG_TTY=$(tty)

