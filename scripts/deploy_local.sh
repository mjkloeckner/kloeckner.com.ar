root_folder="/home/mk/soydev/webp/kloeckner.com.ar"

set -xe

rm -rf /var/www/html &>/dev/null

cp -rf "$root_folder" /var/www/html

rm /var/www/html/{rss_feed_top.xml,README.md} &> /dev/null

systemctl restart nginx
