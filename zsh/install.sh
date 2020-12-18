#!/bin/sh
set -e

[ $(which zsh) ] || sudo apt -y install zsh

ln -nsf $PWD/zsh/zshrc ~/.zshrc

exit 0
