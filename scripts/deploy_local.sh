root_folder="/home/mk/soydev/webp/kloeckner.com.ar"

[[ $EUID -ne 0 ]] && echo "erro: this script must be run with root privileges" && exit 1

set -xe

rm -rf /var/www/html &>/dev/null ||:

cp -rf "$root_folder" /var/www/html

rm /var/www/html/README.md &> /dev/null

systemctl restart nginx
