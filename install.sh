#!/bin/bash

#bashrc
#config
#gitconfig
#kde

DIR=$(pwd)
cd ~

ln -s ${DIR}/bashrc ~/.bashrc

ln -s ${DIR}/gitconfig ~/.gitconfig

ln -s ${DIR}/config/nvim/init.vm ~/.config/nvim/init.vim
ln -s ${DIR}/config/nvim/ginit.vm ~/.config/nvim/ginit.vim

ln -s ${DIR}/config/fish/config.fish ~/.config/fish/config.fish
ln -s ${DIR}/config/fish/fishfile ~/.config/fish/fishfile

ln -s ${DIR}/kde/share/apps/konsole/WhiteOnBlack.colorscheme ~/.kde/share/apps/konsole/WhiteOnBlack.colorscheme
ln -s ${DIR}/kde/share/apps/konsole/Mio.colorscheme          ~/.kde/share/apps/konsole/Mio.colorscheme
ln -s ${DIR}/kde/share/apps/konsole/NeoVim.colorscheme       ~/.kde/share/apps/konsole/NeoVim.colorscheme
ln -s ${DIR}/kde/share/apps/konsole/neovim.profile           ~/.kde/share/apps/konsole/neovim.profile
ln -s ${DIR}/kde/share/apps/konsole/Shell.profile            ~/.kde/share/apps/konsole/Shell.profile
ln -s ${DIR}/kde/share/apps/konsole/Fish.profile             ~/.kde/share/apps/konsole/Fish.profile


