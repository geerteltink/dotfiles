#!/usr/bin/env bash
set -Eueo pipefail

ln -nsf $PWD/bash/.bash_logout ~/.bash_logout
ln -nsf $PWD/bash/.bash_profile ~/.bash_profile
ln -nsf $PWD/bash/.bashrc ~/.bashrc
ln -nsf $PWD/bash/.inputrc ~/.inputrc

exit 0
