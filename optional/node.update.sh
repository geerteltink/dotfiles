#!/usr/bin/env bash
set -Eueo pipefail

source "${DOTFILES_DIR}/lib/log.sh"

if [ -x "$(command -v npm)" ]; then
  log_info "Updating node npm"
  sudo npm install -g npm
  sudo npm update -g
fi

exit 0
