tput sgr0
RED=$(tput setaf 1)
ORANGE=$(tput setaf 3)
GREEN=$(tput setaf 2)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 4)
BLUE=$(tput setaf 6)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
RESET=$(tput sgr0)

log() {
  local LABEL="[$1]"
  local COLOR="$2"
  shift
  shift
  local MSG=("$@")
  for M in "${MSG[@]}"; do
    printf "${COLOR}${LABEL} $M${RESET}\n"
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
