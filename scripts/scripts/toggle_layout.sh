#!/usr/bin/env bash

# Get current layout and variant
layout=$(setxkbmap -query | awk '/layout/ {print $2}')
variant=$(setxkbmap -query | awk '/variant/ {print $2}')

# Toggle logic
if [[ "$layout" == "us" && "$variant" == "colemak_dh" ]]; then
    setxkbmap us
else
    setxkbmap us -variant colemak_dh
fi
