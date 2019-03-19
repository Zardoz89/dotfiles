#!/bin/bash

#bashrc
#config
#gitconfig
#kde

DIR=$(pwd)
cd ~

ln -sf ${DIR}/bashrc ~/.bashrc

ln -sf ${DIR}/gitconfig ~/.gitconfig
ln -sf ${DIR}/gitconfig-common ~/.gitconfig-common
ln -sf ${DIR}/gitconfig-personal ~/.gitconfig-personal
ln -sf ${DIR}/gitconfig-work ~/.gitconfig-work

mkdir -p ~/.config/nvim
ln -sf ${DIR}/config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ${DIR}/config/nvim/ginit.vim ~/.config/nvim/ginit.vim
ln -sf ${DIR}/config/nvim/init.vim ~/.vimrc

mkdir -p ~/.config/fish
ln -sf ${DIR}/config/fish/config.fish ~/.config/fish/config.fish
ln -sf ${DIR}/config/fish/fishfile ~/.config/fish/fishfile

#mkdir -p ~/.kde/share/apps/konsole
#ln -sf ${DIR}/kde/share/apps/konsole/WhiteOnBlack.colorscheme ~/.kde/share/apps/konsole/WhiteOnBlack.colorscheme
#ln -sf ${DIR}/kde/share/apps/konsole/Mio.colorscheme          ~/.kde/share/apps/konsole/Mio.colorscheme
#ln -sf ${DIR}/kde/share/apps/konsole/Shell.profile            ~/.kde/share/apps/konsole/Shell.profile
#ln -sf ${DIR}/kde/share/apps/konsole/Fish.profile             ~/.kde/share/apps/konsole/Fish.profile


mkdir -p ~/.local/share/konsole
ln -sf ${DIR}/kde/share/apps/konsole/WhiteOnBlack.colorscheme ~/.local/share/konsole/WhiteOnBlack.colorscheme
ln -sf ${DIR}/kde/share/apps/konsole/Mio.colorscheme          ~/.local/share/konsole/Mio.colorscheme
ln -sf ${DIR}/kde/share/apps/konsole/Shell.profile            ~/.local/share/konsole/Shell.profile
ln -sf ${DIR}/kde/share/apps/konsole/Fish.profile             ~/.local/share/konsole/Fish.profile


