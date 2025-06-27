#!/usr/bin/env bash
set -Eueo pipefail

[ -d ~/.ssh ] || mkdir ~/.ssh

sudo chown -R $USER:$USER ~/.ssh
sudo chown -R $USER:$USER ~/.ssh/*
sudo chmod 700 -R ~/.ssh
sudo chmod 600 ~/.ssh/*

if [ ! -f ~/.ssh/id_signing ]
then
  ssh-keygen -t ed25519 -C "signing key" -f ~/.ssh/id_signing -q -N ""
fi

if [ ! -f ~/.ssh/id_signing.pub ]
then
  ssh-keygen -y -f ~/.ssh/id_signing > ~/.ssh/id_signing.pub
fi

#
# Import ssh keys and set host config
#
for FILE in ~/.ssh/*.key; do
  [ -f "$FILE" ] || continue
  FILENAME=$(basename $FILE)
  HOST=$(echo $FILENAME | sed 's/.key//')

  # Create public key if it doesn't exist
  if [ ! -f ~/.ssh/$FILENAME.pub ]
  then
    ssh-keygen -y -f ~/.ssh/$FILENAME > ~/.ssh/$FILENAME.pub
  fi

  # Update ssh config
  if ! grep -Fxq "Host $HOST" ~/.ssh/config
  then
    echo "Host $HOST" >> ~/.ssh/config
    echo "    IdentityFile ~/.ssh/$FILENAME" >> ~/.ssh/config
    echo "    ForwardAgent yes" >> ~/.ssh/config
    echo "" >> ~/.ssh/config
  fi
done

#
# Set fallback key
#
# This is added to `/etc/ssh/ssh_config` to make sure it's the last one
#
if [ ! -f ~/.ssh/id_default ]
then
  ssh-keygen -t ed25519 -C "default key" -f ~/.ssh/id_default -q -N ""
fi

if [ ! -f ~/.ssh/id_default.pub ]
then
  ssh-keygen -y -f ~/.ssh/id_default > ~/.ssh/id_default.pub
fi

if ! grep -Fxq "    IdentityFile ~/.ssh/id_default" /etc/ssh/ssh_config
then
  echo "    IdentityFile ~/.ssh/id_default" | sudo tee -a /etc/ssh/ssh_config
fi

sudo chmod 700 -R ~/.ssh
sudo chmod 600 ~/.ssh/*
