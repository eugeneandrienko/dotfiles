#!/bin/bash

if [ "`dirname $0`" != "." ]; then
    echo "This script didn't executed from directory with \
dotfiles repository!"
    exit 1
fi

echo "Deploying..."

FLIST="`echo * .* | sed -r 's/(\.\.)|(\.) //g' | sed 's/README //g' \
| sed 's/deploy.sh //g' | sed 's/\.gitignore //g' | sed 's/\.git //g'`"

echo "List of files:"
echo $FLIST | fold -s -w 40
echo
echo -n "Add symlinks to this files in "'$HOME'" and remove previous \
versions of this files? (y/n) "
read ANSWER
while [ "$ANSWER" != "y" ] && [ "$ANSWER" != "n" ]; do
    echo "Please answer y or n"
    read ANSWER
done
if [ "$ANSWER" == "n" ]; then
    exit 0
fi

for i in $FLIST; do
    rm -rfv $HOME/$i
done

for i in $FLIST; do
    ln -sv $PWD/$i $HOME/$i
done
