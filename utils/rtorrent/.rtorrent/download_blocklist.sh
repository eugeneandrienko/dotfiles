#!/bin/sh

cd ~/.rtorrent/ || exit
wget https://silo.glasz.org/antip2p.list.gz
gzip -fvd antip2p.list.gz

