#!/usr/bin/env bash
set -Eueo pipefail

# Add wslu to open the default browser from cli
if [ ! -f /etc/apt/sources.list.d/wslutilities* ]; then
    sudo add-apt-repository -yu ppa:wslutilities/wslu
fi

PACKAGES=(
  systemd-timesyncd
  wslu
)

for pkg in "${PACKAGES[@]}"; do
  dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt -y install "$pkg"
done

# Auto sync time
sudo mkdir -p /etc/systemd/system/systemd-timesyncd.service.d
sudo tee /etc/systemd/system/systemd-timesyncd.service.d/override.conf >/dev/null <<'EOF'
[Unit]
ConditionVirtualization=
EOF
sudo sudo systemctl daemon-reload
sudo systemctl start systemd-timesyncd

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

exit 0
