#!/bin/sh

root_folder="$1"

if [ "$(id -u)" -ne "0" ] ; then
    echo "This script must be executed with root privileges."
    exit 1
fi

set -xe

rm -drf /var/www/html >/dev/null 2>&1 ||:

cp -rf "$root_folder" /var/www/html

rm /var/www/html/README.md &>/dev/null 2>&1 ||:

sv restart nginx
