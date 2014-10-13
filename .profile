EDITOR="vim"
export EDITOR
LESS="-X"
export LESS

PATH=$PATH":/home/drag0n/.bin/"
export PATH

if [ $USER = drag0n ] && [ "`tty`" = "/dev/tty1" ]; then
    startx &
    exit
fi
