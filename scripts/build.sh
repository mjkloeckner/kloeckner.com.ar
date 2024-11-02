#!/bin/sh

# Builds a page for all the folders contained in md.
# Copies entire folder to blog folder, generates an html file
# converting the markdown file *named the same as the subfolder*

root_folder="$1"

for i in $(ls "$root_folder"/blog); do
	# cp -ur "$root_folder"/md/$i "$root_folder"/blog/ >/dev/null 2>&1
	"$root_folder"/scripts/build_page.sh \
		-i "$root_folder"/blog/$i/$i.md \
		-t "$root_folder"/scripts/template.html \
		-d "$root_folder"/blog/$i;
done
