#!/bin/bash

# Get the default source (microphone)
source_name=$(pactl info | grep "Default Source" | awk '{print $3}')

# Check if it's muted
mute_status=$(pactl get-source-mute "$source_name" | awk '{print $2}')

if [ "$mute_status" = "yes" ]; then
    echo "🎤 Muted"
else
    echo "🎤 Active"
fi

