#!/bin/bash

#bashrc
#config
#gitconfig
#kde

DIR=$(pwd)
cd ~

ln -sf ${DIR}/bashrc ~/.bashrc

ln -s ${DIR}/gitconfig ~/.gitconfig
ln -sf ${DIR}/gitconfig-personal ~/.gitconfig-personal
ln -sf ${DIR}/gitconfig-work ~/.gitconfig-work

ln -sf ${DIR}/config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ${DIR}/config/nvim/ginit.vim ~/.config/nvim/ginit.vim
ln -sf ${DIR}/config/nvim/init.vim ~/.vimrc

ln -sf ${DIR}/config/fish/config.fish ~/.config/fish/config.fish
ln -sf ${DIR}/config/fish/fishfile ~/.config/fish/fishfile

ln -sf ${DIR}/kde/share/apps/konsole/WhiteOnBlack.colorscheme ~/.kde/share/apps/konsole/WhiteOnBlack.colorscheme
ln -sf ${DIR}/kde/share/apps/konsole/Mio.colorscheme          ~/.kde/share/apps/konsole/Mio.colorscheme
ln -sf ${DIR}/kde/share/apps/konsole/Shell.profile            ~/.kde/share/apps/konsole/Shell.profile
ln -sf ${DIR}/kde/share/apps/konsole/Fish.profile             ~/.kde/share/apps/konsole/Fish.profile


ln -sf ${DIR}/kde/share/apps/konsole/WhiteOnBlack.colorscheme ~/.local/share/konsole/WhiteOnBlack.colorscheme
ln -sf ${DIR}/kde/share/apps/konsole/Mio.colorscheme          ~/.local/share/konsole/Mio.colorscheme
ln -sf ${DIR}/kde/share/apps/konsole/Shell.profile            ~/.local/share/konsole/Shell.profile
ln -sf ${DIR}/kde/share/apps/konsole/Fish.profile             ~/.local/share/konsole/Fish.profile


