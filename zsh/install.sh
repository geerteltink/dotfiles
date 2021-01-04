#!/bin/bash
set -e

[ $(which zsh) ] || sudo apt -y install zsh

if [ ! -d $HOME/.dotfiles/plugins/powerlevel10k ]
then
    git submodule update --init --recursive
fi

git submodule update --recursive

ln -nsf $PWD/zsh/zshrc ~/.zshrc

exit 0
