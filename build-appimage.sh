#!/bin/bash

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# Retry if 503 error occurs, is a ostre bug
sudo flatpak install -v --noninteractive --system flathub $1.Locale || {
  sudo flatpak install -v --noninteractive --system flathub $1.Locale || true
}
sudo flatpak install -v --noninteractive --system flathub $1
./flatpak2appdir $1
