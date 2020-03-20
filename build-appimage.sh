#!/bin/bash

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Retry if 503 error occurs, is a ostre bug
sudo flatpak install -v --noninteractive --system flathub $1.Locale || {
  sudo flatpak install -v --noninteractive --system flathub $1.Locale || true
}
sudo flatpak install -v --noninteractive --system flathub $1
sudo ./flatpak2appdir $1

export VERSION=$(LANG=en flatpak info $ID | sed 's/^[[:space:]]*//'  | grep -i ^Version: | cut -c 10-)
DESKTOPFILENAME=$(ls ./*.AppDir/*.desktop | cut -d / -f 3)
./appimagetool-*.AppImage -s deploy ./*.AppDir/usr/share/applications/$DESKTOPFILENAME
./appimagetool-*.AppImage ./*.AppDir
rm ./appimagetool-*.AppImage
