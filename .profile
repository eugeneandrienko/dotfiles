EDITOR="vi";            export EDITOR
LESS="-XR";             export LESS
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:$HOME/bin; export PATH
BLOCKSIZE=K;	        export BLOCKSIZE
PAGER=less;  	        export PAGER
ENV=$HOME/.bashrc;      export ENV
BASH_ENV=$HOME/.bashrc; export BASH_ENV

if [ $USER = drag0n ] && [ "`tty`" = "/dev/tty1" ]; then
    startx &
    exit
fi
