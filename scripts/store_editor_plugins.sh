#!/usr/bin/env zsh

FILENAME="editor_plugins_$(date '+%Y%m%d_%H%M')"

tar cf "$FILENAME.tar" -C ~ .emacs.d/elpa
tar rf "$FILENAME.tar" -C ~ .vim/bundle

gzip --keep -9 $FILENAME.tar
rm -f "$FILENAME.tar"
ls -l $FILENAME.tar.gz
