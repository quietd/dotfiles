#!/usr/bin/env bash
# Creates launcher entries for Chromium --app windows (no toolbar)

DIR="$HOME/.local/share/applications"
mkdir -p "$DIR"

make_app() {
  local file="$1" name="$2" url="$3" icon="$4"
  cat > "$DIR/$file.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Name=$name
Exec=/usr/bin/chromium --profile-directory=Default --app=$url
Icon=$icon
Categories=Network;
EOF
}

#         file      name       url                           icon
make_app  reddit    "Reddit"   "https://www.reddit.com"      "$HOME/.local/share/icons/reddit.png"
make_app  whatsapp  "WhatsApp" "https://web.whatsapp.com"    "$HOME/.local/share/icons/whatsapp.png"
make_app  telegram  "Telegram" "https://web.telegram.org/a/" "$HOME/.local/share/icons/telegram.png"
make_app  youtube   "Youtube"  "https://www.youtube.com"     "$HOME/.local/share/icons/youtube.png"
make_app  github    "github"   "https://www.github.com"      "$HOME/.local/share/icons/github.png"

update-desktop-database "$DIR"
echo "Done."
