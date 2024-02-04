#!/usr/bin/env bash
set -Eueo pipefail

source "${DOTFILES_DIR}/lib/log.sh"

if [ -x "$(command -v npm)" ]; then
  log_info "Updating node npm"
  sudo npm install -g npm
  sudo npm update -g
fi

if [ -x "$(command -v bun)" ]; then
  log_info "Updating bun"
  bun upgrade
else
  curl -fsSL https://bun.sh/install | sudo bash
fi

exit 0
