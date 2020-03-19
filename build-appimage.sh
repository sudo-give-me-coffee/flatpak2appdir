#!/bin/bash

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -v --noninteractive --system flathub $1
sudo ./flatpak2appdir $1

export VERSION=$(LANG=en flatpak info $ID | sed 's/^[[:space:]]*//'  | grep -i ^Version: | cut -c 10-)

./appimagetool-*.AppImage ./*.AppDir
rm ./appimagetool-*.AppImage
