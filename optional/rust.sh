#!/usr/bin/env bash
set -Eueo pipefail

PACKAGES=(
  gcc
)

for pkg in "${PACKAGES[@]}"; do
  dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
done

curl https://sh.rustup.rs -sSf | sh -s -- -y

exit 0
