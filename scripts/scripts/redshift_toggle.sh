#!/bin/bash

# File to track redshift state
STATE_FILE="/tmp/redshift_state"

# Check if the state file exists and read its value
if [ ! -f "$STATE_FILE" ]; then
    echo "off" > $STATE_FILE
fi

STATE=$(cat $STATE_FILE)

if [ "$STATE" = "off" ]; then
    redshift -P -O 3000
    echo "on" > $STATE_FILE
else
    redshift -P -O 6500
    echo "off" > $STATE_FILE
fi
fil
