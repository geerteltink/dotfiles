#!/usr/bin/env bash
set -Eueo pipefail

sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt -y update

PACKAGES=(
  thermald
  tlp
  tlp-rdw
  powertop
)

for pkg in "${PACKAGES[@]}"; do
  dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt -y install "$pkg"
done

sudo powertop --auto-tune

exit 0
