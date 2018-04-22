#!/bin/bash

cd ./progress/
make
if [ "$?" -ne "0" ]; then
    exit 1
fi
cd ..

cd ./ddgr/
make test
if [ "$?" -ne "0" ]; then
    exit 1
fi
cd ..

