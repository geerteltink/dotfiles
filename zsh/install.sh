#!/usr/bin/env bash
set -Eueo pipefail

[ $(which zsh) ] || sudo apt -y install zsh

if [ ! -d $HOME/.dotfiles/.powerlevel10k ]
then
    git submodule update --init --recursive
fi

git submodule update --recursive

ln -nsf $PWD/zsh/zshrc ~/.zshrc

exit 0
