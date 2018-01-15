#!/bin/bash

#bashrc
#config
#gitconfig
#kde

DIR=$(pwd)
cd ~

ln -s ${DIR}/bashrc ~/.bashrc

ln -s ${DIR}/gitconfig ~/.gitconfig

ln -s ${DIR}/config/nvim/init.vim ~/.config/nvim/init.vim
ln -s ${DIR}/config/nvim/ginit.vim ~/.config/nvim/ginit.vim
ln -s ${DIR}/config/nvim/init.vim ~/.vimrc

ln -s ${DIR}/config/fish/config.fish ~/.config/fish/config.fish
ln -s ${DIR}/config/fish/fishfile ~/.config/fish/fishfile

ln -s ${DIR}/kde/share/apps/konsole/WhiteOnBlack.colorscheme ~/.kde/share/apps/konsole/WhiteOnBlack.colorscheme
ln -s ${DIR}/kde/share/apps/konsole/Mio.colorscheme          ~/.kde/share/apps/konsole/Mio.colorscheme
ln -s ${DIR}/kde/share/apps/konsole/Shell.profile            ~/.kde/share/apps/konsole/Shell.profile
ln -s ${DIR}/kde/share/apps/konsole/Fish.profile             ~/.kde/share/apps/konsole/Fish.profile


ln -s ${DIR}/kde/share/apps/konsole/WhiteOnBlack.colorscheme ~/.local/share/konsole/WhiteOnBlack.colorscheme
ln -s ${DIR}/kde/share/apps/konsole/Mio.colorscheme          ~/.local/share/konsole/Mio.colorscheme
ln -s ${DIR}/kde/share/apps/konsole/Shell.profile            ~/.local/share/konsole/Shell.profile
ln -s ${DIR}/kde/share/apps/konsole/Fish.profile             ~/.local/share/konsole/Fish.profile


