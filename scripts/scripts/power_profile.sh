#!/bin/bash

last=""

while true; do
    current=$(cat /sys/firmware/acpi/platform_profile)

    if [[ "$current" != "$last" ]]; then
        case "$current" in
            performance)
                hyprctl notify -1 3000 "rgb(ff4444)" "Performance"
                ;;
            balanced)
                hyprctl notify -1 3000 "rgb(ffffff)" "Balanced"
                ;;
            low-power)
                hyprctl notify -1 3000 "rgb(44aaff)" "Low Power"
                ;;
        esac

        last="$current"
    fi

    sleep 0.5
done
