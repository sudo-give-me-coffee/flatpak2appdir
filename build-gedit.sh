#!/bin/bash

# Retry if 503 error occurs, is a ostre bug
sudo flatpak install -v --noninteractive --system flathub org.gnome.gedit.Locale || {
  sudo flatpak install -v --noninteractive --system flathub org.gnome.gedit.Locale
}
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -v --noninteractive --system flathub org.gnome.gedit
sudo ./flatpak2appdir org.gnome.gedit

export VERSION=$(LANG=en flatpak info org.gnome.gedit | sed 's/^[[:space:]]*//'  | grep -i ^Version: | cut -c 10-)

./appimagetool-*.AppImage ./*.AppDir
rm ./appimagetool-*.AppImage
