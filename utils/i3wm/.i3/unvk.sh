#!/usr/bin/env bash

xclip -out | \
    sed -r 's/https:\/\/vk\.com\/away\.php\?to=(.*)$/\1/g' | \
    sed -r 's/(.*)&cc_key=/\1/g' | \
    sed -r 's/(.*)&post=[-0-9_]+/\1/g' | \
    python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));" | xclip -in

