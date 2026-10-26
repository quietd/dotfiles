#!/usr/bin/env bash
ROFI_THEME="$HOME/.config/rofi/launchers/type-1/style-3.rasi"
BOOKS_DIR="$HOME/Books"

current="$BOOKS_DIR"

while true; do
  # list subdirs + books in current dir
  entries=$(
    {
      find "$current" -mindepth 1 -maxdepth 1 -type d -printf '📁 %f\n'
      find "$current" -mindepth 1 -maxdepth 1 -type f \( -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" \) -printf '📖 %f\n'
    } | sort
  )

  # add a "go back" option if not at root
  if [ "$current" != "$BOOKS_DIR" ]; then
    entries=$(printf '.. \n%s' "$entries")
  fi

  choice=$(echo "$entries" | rofi -dmenu -theme "$ROFI_THEME" -i -p "$(basename "$current")")

  [ -z "$choice" ] && exit 0

  if [ "$choice" == ".. " ]; then
    current=$(dirname "$current")
    continue
  fi

  name="${choice#* }"  # strip the emoji prefix

  if [[ "$choice" == 📁* ]]; then
    current="$current/$name"
    continue
  elif [[ "$choice" == 📖* ]]; then
    zathura "$current/$name" &
    exit 0
  fi
done
