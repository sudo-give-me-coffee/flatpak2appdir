#!/bin/bash

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Retry if 503 error occurs, is a ostre bug
flatpak install -v --noninteractive --user flathub $1.Locale || {
  flatpak install -v --noninteractive --user flathub $1.Locale || true
}
flatpak install -v --noninteractive --user flathub $1
bash -ex flatpak2appdir $1

export VERSION=$(LANG=en flatpak info $ID | sed 's/^[[:space:]]*//'  | grep -i ^Version: | cut -c 10-)

./appimagetool-*.AppImage ./*.AppDir
rm ./appimagetool-*.AppImage
