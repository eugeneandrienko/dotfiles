#!/usr/bin/env bash

if wget -c https://josm.openstreetmap.de/josm-tested.jar -O josm-tested-new.jar; then
    mkdir -p $HOME/bin/josm
    mv -v josm-tested-new.jar $HOME/bin/josm/josm-tested.jar
else
    echo "Failed to update JOSM!"
    rm -fv josm-tested-new.jar
    exit 1
fi

