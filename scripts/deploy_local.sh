#!/bin/sh

root_folder="$1"
html_folder="/var/www/html"

if [ "$(id -u)" -ne "0" ] ; then
	echo "This script must be executed with root privileges."
	exit 1
fi

echo -n "override folder $html_folder with $root_folder? (Y/n)? "
read answer

if [ "$answer" != "${answer#[Yy]}" ] || [ "$answer" = "" ]; then
	rm -drf "$html_folder" >/dev/null 2>&1 ||:
	cp -rf "$root_folder" "$html_folder"
else
	echo "skipping ..."
fi

set -xe

rm "$html_folder"/README.md &>/dev/null 2>&1 ||:

systemctl restart nginx
