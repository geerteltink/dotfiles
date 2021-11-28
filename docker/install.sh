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
    dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
  done

  # Add docker repo
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update

  # Install docker
  DOCKER_PACKAGES=(
    docker-ce
    docker-ce-cli
    containerd.io
  )

  for pkg in "${DOCKER_PACKAGES[@]}"; do
    dpkg -s $pkg > /dev/null 2>&1 || sudo apt -y install $pkg
  done

  # Add current user to docker group
  sudo groupadd docker --force
  sudo usermod -aG docker $USER
fi

# Install docker compose
COMPOSE_VERSION=$(curl -fsSL -o /dev/null -w "%{url_effective}" "https://github.com/docker/compose/releases/latest" | xargs basename)
curl -fsSL --create-dirs -o ~/.docker/cli-plugins/docker-compose "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-$(uname -m)"
chmod +x ~/.docker/cli-plugins/docker-compose

# Install docker compose switch
SWITCH_VERSION=$(curl -fsSL -o /dev/null -w "%{url_effective}" "https://github.com/docker/compose-switch/releases/latest" | xargs basename)
sudo curl -fsSL -o /usr/local/bin/docker-compose "https://github.com/docker/compose-switch/releases/download/${SWITCH_VERSION}/docker-compose-linux-$(dpkg --print-architecture)"
sudo chmod +x /usr/local/bin/docker-compose

# Install docker credential helper
WINCRED_VERSION=$(curl -fsSL -o /dev/null -w "%{url_effective}" "https://github.com/docker/docker-credential-helpers/releases/latest" | xargs basename)
sudo curl -fsSL "https://github.com/docker/docker-credential-helpers/releases/download/${WINCRED_VERSION}/docker-credential-wincred-${WINCRED_VERSION}-amd64.zip" | zcat | sudo tee /usr/bin/docker-credential-wincred.exe >/dev/null
sudo chmod +x /usr/bin/docker-credential-wincred.exe

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

sudo crudini --set /etc/wsl.conf boot command '"service docker start"'

exit 0
