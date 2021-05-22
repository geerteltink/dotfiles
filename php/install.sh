#!/usr/bin/env bash
set -Eueo pipefail

if [ ! -f /etc/apt/sources.list.d/ondrej*.list ]; then
    sudo add-apt-repository -yu ppa:ondrej/php
fi

if [ ! $(which php) ]
then
    sudo apt -y install php8.0-{common,cli,bcmath,curl,gd,intl,mbstring,xml,mysql,ldap,redis,sqlite3}
fi

if [ ! $(which composer) ]; then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

sudo composer self-update

exit 0
