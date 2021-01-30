#!/usr/bin/env bash
set -Eueo pipefail

sudo sysctl -w fs.inotify.max_user_watches=524288

exit 0
