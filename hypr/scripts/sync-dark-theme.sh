#!/bin/sh
current=$(gsettings get org.gnome.desktop.interface color-scheme)
if [ "$current" = "'default'" ]; then
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
fi
