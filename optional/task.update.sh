#!/usr/bin/env bash
set -Eueo pipefail

source "${DOTFILES_DIR}/lib/log.sh"

if [ -x "$(command -v task)" ]; then
  log_info "Updating task"
  sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/bin
fi

exit 0
