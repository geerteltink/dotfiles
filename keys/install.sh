#!/usr/bin/env bash
set -Eueo pipefail

#
# Import gpg keys with extension `.pgp.key`
#
for FILE in keys/*.pgp.key; do
    [ -f "$FILE" ] || continue
    gpg --import $FILE
    rm $FILE
done

#
# Import ssh keys with extension `.rsa.key`
#
[ -d ~/.ssh ] || mkdir ~/.ssh
sudo chmod 700 -R ~/.ssh
sudo chmod 600 ~/.ssh/*
for FILE in keys/*.rsa.key; do
    [ -f "$FILE" ] || continue
    FILENAME=$(basename $FILE)
    HOST=$(echo $FILENAME | sed 's/.rsa.key//')

    # Copy key if it doesn't exist
    if [ ! -f ~/.ssh/$FILENAME ]
    then
        cp $FILE ~/.ssh
        sudo chmod 600 ~/.ssh/$FILENAME
    fi

    # Create public key if it doesn't exist
    if [ ! -f ~/.ssh/$FILENAME.pub ]
    then
        ssh-keygen -y -f ~/.ssh/$FILENAME > ~/.ssh/$FILENAME.pub

        # Update ssh config
        if [ $HOST != "default" ]
        then
            echo "Host $HOST" >> ~/.ssh/config
            echo "    IdentityFile ~/.ssh/$FILENAME" >> ~/.ssh/config
            echo "    ForwardAgent yes" >> ~/.ssh/config
            echo "" >> ~/.ssh/config
        fi
    fi

    rm $FILE
done

#
# Set fallback key
#
# This is added to `/etc/ssh/ssh_config` to make sure it's the last one
#
if ! grep -Fxq "IdentityFile ~/.ssh/default.rsa.key" /etc/ssh/ssh_config
then
    echo "IdentityFile ~/.ssh/default.rsa.key" | sudo tee -a /etc/ssh/ssh_config
fi
