#!/bin/sh
set -e

if [ ! -f /etc/apt/sources.list.d/node*.list ]
then
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
fi

if [ ! $(which node) ]
then
    sudo apt install -y build-essential gcc g++ make nodejs
fi

if [ ! $(which yarn) ]
then
    sudo npm install -g yarn
fi

sudo npm install -g npm
sudo npm update -g

exit 0
