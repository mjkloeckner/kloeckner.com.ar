#!/bin/sh

# Builds a page for all the folders contained in md.
# Copies entire folder to blog folder, generates an html file
# converting the markdown file *named the same as the subfolder*,
# then removes the md file conbtained in the dest folder.

# TODO: leave markdown file to generate a description for the rss feed
for i in $(ls md); do
	cp -r md/$i ./blog &> /dev/null;
	./build_page.sh -i md/$i/$i.md -t template.html -d ./blog/$i;
	# rm -r ./blog/$i/$i.md;
done
