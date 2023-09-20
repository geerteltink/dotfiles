#!/usr/bin/env bash
set -Eueo pipefail

PACKAGES=(
  ntp
  ntpdate
)

for pkg in "${PACKAGES[@]}"; do
  dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
done

# Auto sync time
sudo ntpdate -u pool.ntp.org

# Use max file watches
sudo sysctl -w fs.inotify.max_user_watches=524288

# Generate missing locale
sudo locale-gen en_US
sudo locale-gen en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8

# Disable apt update ubuntu pro esm warnings
sudo [ -s "$HOME/.nvm/bash_completion" ] && rm /etc/apt/apt.conf.d/20apt-esm-hook.conf

# Configure WSL
sudo crudini --set /etc/wsl.conf boot systemd true
sudo crudini --set /etc/wsl.conf wsl2 memory 16GB
sudo crudini --set /etc/wsl.conf wsl2 processors 8
sudo crudini --set /etc/wsl.conf experimental autoMemoryReclaim gradual
sudo crudini --set /etc/wsl.conf experimental sparseVhd true

exit 0
