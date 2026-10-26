!/bin/sh

Load Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

exec i3
