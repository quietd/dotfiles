#!/bin/sh
last="x"
while true; do
    if grep -q 1 /sys/class/leds/input*::capslock/brightness; then
        cur="CAPS"
    else
        cur=""
    fi
    if [ "$cur" != "$last" ]; then
        echo "$cur"
        last="$cur"
    fi
    sleep 0.1
done
