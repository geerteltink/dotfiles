#!/bin/sh
set -e

sudo sysctl -w fs.inotify.max_user_watches=524288

exit 0
