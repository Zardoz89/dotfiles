#!/bin/bash

# Materia theme for KDE and GTK
sudo add-apt-repository ppa:papirus/papirus
sudo apt update
sudo apt-get install --install-recommends materia-kde materia-gtk-theme

# suru plus aspromauros icon theme
wget -qO- https://raw.githubusercontent.com/gusbemacbe/suru-plus-aspromauros/master/install.sh | sh


