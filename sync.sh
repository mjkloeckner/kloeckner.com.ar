#!/bin/sh

PROJECT_FOLDER='/home/mk/soydev/webp'

cp -r $PROJECT_FOLDER/** /usr/share/nginx/html/

systemctl restart nginx
