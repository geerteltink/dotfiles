#!/usr/bin/env bash
set -Eueo pipefail

if [ ! -f /etc/apt/sources.list.d/docker.list ]
then
  # Remove old packages
  sudo apt remove docker docker.io containerd runc

  # Install dependencies
  PACKAGES=(
    lsb-release
  )

  for pkg in "${PACKAGES[@]}"; do
    dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt -y install "$pkg"
  done

  # Add docker repo
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt update
fi

# Install docker
DOCKER_PACKAGES=(
  docker-ce
  docker-ce-cli
  containerd.io
)

for pkg in "${DOCKER_PACKAGES[@]}"; do
  dpkg -s "$pkg" >/dev/null 2>&1 || sudo apt -y install "$pkg"
done

# Add current user to docker group
sudo groupadd docker --force
sudo usermod -aG docker "$USER"

if [[ ! -f ~/.docker/config.json ]]; then
  sudo mkdir -p ~/.docker
  sudo chown -R $USER:$USER ~/.docker
  echo '{}' | sudo tee ~/.docker/config.json >/dev/null
fi
sudo rm ~/.docker/config.json.tmp 2>/dev/null || true
sudo jq -s add ~/.docker/config.json "$PWD/optional/docker-config.json" > ~/.docker/config.json.tmp
sudo mv ~/.docker/config.json.tmp ~/.docker/config.json

if [[ ! -f /etc/docker/daemon.json ]]; then
  sudo mkdir -p /etc/docker
  echo '{}' | sudo tee /etc/docker/daemon.json >/dev/null
fi
sudo rm /etc/docker/daemon.json.tmp 2>/dev/null || true
sudo jq -s add /etc/docker/daemon.json "$PWD/optional/docker-daemon.json" > ~/.docker/daemon.json.tmp
sudo mv ~/.docker/daemon.json.tmp /etc/docker/daemon.json

exit 0
