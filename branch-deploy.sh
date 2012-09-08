#!/bin/sh

git push origin master

BRANCHES_LIST=`git branch -a | grep \
remotes | grep -v master | sed -r 's/.*remotes\/origin\/(.*)/\1/g'`

for i in $BRANCHES_LIST; do
    git checkout "$i"
    git cherry-pick "$1"
    git push origin  "$i"
done
