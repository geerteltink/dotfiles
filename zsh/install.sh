#!/usr/bin/env bash
set -Eueo pipefail

[ $(which zsh) ] || sudo apt -y install zsh

ln -nsf $PWD/zsh/zshrc ~/.zshrc

exit 0
