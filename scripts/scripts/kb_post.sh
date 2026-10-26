#!/usr/bin/env bash
hyprctl eval 'hl.config({ input = { kb_layout = "us,us,ru", kb_variant = "colemak_dh,," } })' \
  && notify-send "Hyprland" "Post-launch keyboard config applied"
