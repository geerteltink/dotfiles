#!/usr/bin/env bash
set -Eueo pipefail

source "${DOTFILES_DIR}/lib/log.sh"

if [ -x "$(command -v composer)" ]; then
  log_info "Updating php composer"
  sudo composer self-update --no-plugins --no-scripts --quiet --stable
fi

exit 0
