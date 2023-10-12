#!/usr/bin/env sh

cd ~/.rtorrent/ || exit
wget 'http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=cidr&archiveformat=gz' -O antip2p.list.gz
gzip -fvd antip2p.list.gz

