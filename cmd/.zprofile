LC_MESSAGES="C";        export LC_MESSAGES

PATH=$HOME/.bin/:$HOME/.cabal/bin/:$PATH:/usr/local/bin/:$HOME/.local/bin/
export PATH

COLORTERM=truecolor
export COLORTERM

if [ -d ~/.termux ];
    echo "Calling termux-chroot"
    termux-chroot
fi

