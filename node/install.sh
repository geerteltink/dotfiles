#!/usr/bin/env bash
set -Eueo pipefail

NODECMD=$(which node)
if [ $NODECMD != "" ]
then
  VERSION=$($NODECMD --version)
  [[ $VERSION =~ ^v16.* ]] || sudo rm /etc/apt/sources.list.d/node*.list
fi

if [ ! -f /etc/apt/sources.list.d/node*.list ]
then
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

PACKAGES=(
  build-essential
  gcc
  g++
  make
  nodejs
)

for pkg in "${PACKAGES[@]}"; do
  [ ! $(dpkg -s $pkg >/dev/null 2>&1;) ] || sudo apt -y install $pkg
done

[ ! $(dpkg -s yarn >/dev/null 2>&1;) ] || sudo npm install -g yarn
[ ! $(npm outdated -g npm >/dev/null 2>&1;) ] || sudo npm install -g npm
[ ! $(npm outdated -g >/dev/null 2>&1;) ] || sudo npm update -g

exit 0
