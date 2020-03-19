#!/bin/bash

export LANG=en
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -v --noninteractive --system flathub org.gnome.gedit
sudo flatpak remove -v --noninteractive --system org.gnome.gedit.Locale
sudo flatpak install -v --noninteractive --system flathub org.gnome.gedit.Locale
sudo ./flatpak2appdir org.gnome.gedit

export VERSION=$(flatpak info org.gnome.gedit | sed 's/^[[:space:]]*//'  | grep -i ^Version: | cut -c 10-)

./appimagetool-*.AppImage ./*.AppDir
