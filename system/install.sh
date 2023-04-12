#!/usr/bin/env bash
set -Eueo pipefail

PACKAGES=(
  ntp
  ntpdate
)

for pkg in "${PACKAGES[@]}"; do
  dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
done

sudo ntpdate -u pool.ntp.org
sudo sysctl -w fs.inotify.max_user_watches=524288

exit 0
