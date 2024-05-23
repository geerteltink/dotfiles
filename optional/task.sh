#!/usr/bin/env bash
set -Eueo pipefail

sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/bin

exit 0
