#!/bin/sh

# Builds a page for all the folders contained in md.
# Copies entire folder to blog folder, generates an html file
# converting the markdown file *named the same as the subfolder*,
# then removes the md file conbtained in the dest folder.

# TODO: leave markdown file to generate a description for the rss feed

root_folder="/home/mk/soydev/webp/kloeckner.com.ar"

for i in $(ls /home/mk/soydev/webp/kloeckner.com.ar/md); do
	cp -r "$root_folder"/md/$i "$root_folder"/blog &>/dev/null;
	"$root_folder"/scripts/build_page.sh -i "$root_folder"/md/$i/$i.md -t "$root_folder"/scripts/template.html -d "$root_folder"/blog/$i;
done
