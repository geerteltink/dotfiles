#!/usr/bin/env bash
set -Eueo pipefail

curl -s https://repos.azul.com/azul-repo.key | sudo gpg --dearmor --yes -o /usr/share/keyrings/azul.gpg
echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | sudo tee /etc/apt/sources.list.d/zulu.list
sudo apt update

sudo apt install -y zulu21-jdk

exit 0
