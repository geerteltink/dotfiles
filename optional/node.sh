#!/usr/bin/env bash
set -Eueo pipefail

NODE_MAJOR=22

if [ ! -f /etc/apt/sources.list.d/node*.list ]
then
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt update
fi

PACKAGES=(
  build-essential
  gcc
  g++
  make
  nodejs
)

for pkg in "${PACKAGES[@]}"; do
  dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt -y install "$pkg"
done

exit 0
