#!/usr/bin/env bash
set -Eueo pipefail

source "${DOTFILES_DIR}/lib/log.sh"

if ! [ -x "$(command -v rustup)" ]; then
  exit 0
fi

log_info "Updating rust"

rustup update

exit 0
