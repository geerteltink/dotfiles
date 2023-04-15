#!/usr/bin/env bash
#
# sudo apt purge 'php*'
#
# Switch PHP versions with
#
# $ sudo update-alternatives --config php
#
set -Eueo pipefail

if [ ! -f /etc/apt/sources.list.d/ondrej*.list ]; then
    sudo add-apt-repository -yu ppa:ondrej/php
fi

if [ ! -f /usr/bin/php8.2 ]
then
    sudo apt -y install php8.2-{common,cli,bcmath,curl,gd,intl,mbstring,xml,mysql,ldap,redis,sqlite3}
    sudo update-alternatives --set php /usr/bin/php8.2
fi

if [ ! $(which composer) ]; then
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
fi

sudo composer self-update --no-plugins --no-scripts --quiet --stable

exit 0
