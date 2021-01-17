#!/usr/bin/env bash

if [ "$#" -eq "0" ]; then
    echo "No one commit hash given!"
    exit 1
fi

CURRENT_BRANCH=$(git branch --no-color --show-current)
BRANCHES=$(git branch --format='%(refname:short)' | grep -v "$CURRENT_BRANCH")

for branch in $BRANCHES; do
    git checkout "$branch"
    git pull --rebase
    git cherry-pick "$@"
    git push origin
    git push e
done

git checkout "$CURRENT_BRANCH"

