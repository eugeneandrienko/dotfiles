#!/usr/bin/env bash

source ~/.bin/get_machine_id.sh
if [ "$MACHINE_HW" = "zalman" ]; then
    /usr/bin/env fdm -l fetch
fi

