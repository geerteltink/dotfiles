#!/usr/bin/env bash
set -Eueo pipefail

if [ ! -f /etc/apt/sources.list.d/docker.list ]
then
  # Remove old packages
  sudo apt remove docker docker-engine docker-ce docker.io containerd runc

  # Install dependencies
  PACKAGES=(
    lsb-release
  )

  for pkg in "${PACKAGES[@]}"; do
    dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
  done

  # Add docker repo
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
fi

# Install docker
DOCKER_PACKAGES=(
  docker-ce
  docker-ce-cli
  containerd.io
  docker-buildx-plugin
  docker-compose-plugin
)

for pkg in "${DOCKER_PACKAGES[@]}"; do
  dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
done

# Add current user to docker group
sudo groupadd docker --force
sudo usermod -aG docker $USER

if [ ! -f /usr/local/bin/docker-compose ]
then
  curl -fL https://raw.githubusercontent.com/docker/compose-switch/master/install_on_linux.sh | sudo sh
fi

if [[ ! -f ~/.docker/config.json ]]; then
  sudo mkdir -p ~/.docker/config.json
  echo '{}' | sudo tee ~/.docker/config.json >/dev/null
fi
sudo jq -s add ~/.docker/config.json $PWD/docker/config.json

if [[ ! -f /etc/docker/daemon.json ]]; then
  sudo mkdir -p /etc/docker
  echo '{}' | sudo tee /etc/docker/daemon.json >/dev/null
fi
sudo jq -s add /etc/docker/daemon.json $PWD/docker/daemon.json

sudo crudini --set /etc/wsl.conf boot systemd '"true"'
sudo crudini --set /etc/wsl.conf boot command '"service docker start"'

exit 0
