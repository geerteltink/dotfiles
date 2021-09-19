#!/usr/bin/env bash
set -Eueo pipefail

if [ ! $(which oh-my-posh) ]
then
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh
fi

exit 0
