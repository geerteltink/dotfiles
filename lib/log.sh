#!/usr/bin/env bash

tput sgr0
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 6)
RESET=$(tput sgr0)

log() {
  local LABEL="[$1]"
  local COLOR="$2"
  shift
  shift
  local MSG=("$@")
  for M in "${MSG[@]}"; do
    printf "%s%s $M$%s\n" "$COLOR" "$LABEL" "$RESET"
  done
}

log_error() {
  log "FAIL" "$RED" "$@"
  exit 1
}

log_info() {
  log "INFO" "$BLUE" "$@"
}

log_success() {
  log "OK" "$GREEN" "$@"
}
