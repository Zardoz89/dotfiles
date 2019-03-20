#!/bin/bash

# ARC theme KDE/Qt
sudo add-apt-repository ppa:papirus/papirus
sudo apt update
sudo apt-get install --install-recommends arc-kde

# ARC theme GTK
sudo add-apt-repository ppa:noobslab/themes
sudo apt update
sudo apt install arc-theme

