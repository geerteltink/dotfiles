#!/usr/bin/env bash
set -Eueo pipefail

source "${DOTFILES_DIR}/lib/log.sh"

if [ -x "$(command -v rustup)" ]; then
  log_info "Updating rust"
  rustup update
fi

exit 0
