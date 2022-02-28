#!/usr/bin/env bash
set -Eueo pipefail

if [ -d /opt/phpstorm ]; then
   exit 0
fi

if [ ! -f /tmp/PhpStorm.tar.gz ]; then
    wget -O /tmp/PhpStorm.tar.gz https://download.jetbrains.com/webide/PhpStorm-2021.2.1.tar.gz
fi

tar -xzf /tmp/PhpStorm.tar.gz -C /tmp
sudo rm /tmp/PhpStorm.tar.gz

for dir in /tmp/PhpStorm-*/
do
    sudo rm -rf /opt/phpstorm/
    sudo mv ${dir} /opt/phpstorm/
    sudo rm -rf ${dir}
    sudo ln -nsf /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm
done

exit 0
