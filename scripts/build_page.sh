#!/bin/sh

# The most bloated, non-mantainable, non-readable static site generator
# by: Martin Kloeckner - https://kloeckner.com.ar
# Dependencies: sed, grep, lowdown.

# Template: the converted html text is placed on a copy of the template
# containing $body$ on it, $body$ then gets deleted.
# Also the template should contain an $article-title$, $article-date$ and
# $pagetitle$

# The article title is considered to be the first h1 header found
# in the markdown file

div_article_title_w_logo() {
	logo_src=$(echo $1 | grep -zoP '(?<=src=\")(.*?)(?=\")' | tr -d '\0')
	logo_alt=$(echo $1 | grep -zoP '(?<=alt=\")(.*?)(?=\")' | tr -d '\0')
	logo_title=$(echo $1 | grep -zoP '(?<=title=\")(.*?)(?=\")' | tr -d '\0')
	h1_title=$(echo $2 | grep -zoP '(?<=<h1 id=article-title>)(.*?)(?=</h1>)' |\
		tr -d '\0')
}

usage() {
	echo "usage: $0 -i <input_file> -t <template_file>"
}

missing_operand() {
	echo "$0: missing operands"
	usage
}

check_opt() {
	local opt OPTIND
	while getopts ":i:t:d:" opt; do
		case $opt in
			i) input="$OPTARG";;
			t) templ="$OPTARG";;
			d) dest_dir="$OPTARG";;
			\?) printf "%s\n\n" "error: flag not found" && usage && exit 1;;
		esac
	done

	[ $OPTIND -eq 1 ] && missing_operand && exit 2
	shift "$((OPTIND-1))"

	[ -z "$input" ] || [ ! -e "$input" ] &&\
		echo "error: no input file" && exit 1
	[ -z "$templ" ] || [ ! -e "$templ" ] &&\
		echo "error: no template fshellile" && exit 1
	[ -z "$dest_dir" ] && dest_dir="."
}

check_opt $@

# deprecated format
# title=$(cat $input | head -n 3 | grep -oP '(?<=% title: \")(.*?)(?=\")')
# date=$(cat $input | head -n 3 | grep -oP '(?<=% date: \")(.*?)(?=\")')

title=$(cat $input | sed '/^%%/,/^%%/!d' | grep -oP '(?<=title: \")(.*?)(?=\")')
date=$(cat $input | sed '/^%%/,/^%%/!d' | grep -oP '(?<=date: \")(.*?)(?=\")')
pagetitle="Martin Klöckner's Webpage"
lang="en"
generator="Shell script"
template="$templ"
filename="$(basename $input | sed 's/\.[^.]*$//')"
# last_update="$(date -r $input '+%d-%b-%Y')"
last_update="$(git --no-pager log -n 1 --date=format:'%d-%b-%Y' --pretty=format:%cd $input)"

mkdir -p $dest_dir &> /dev/null

echo "title: $title"
echo "date: $date"

[ -z "$title" ] || [ -z "$date" ] \
	&& echo "error: no metadata found on file $input" && exit 1

# generate body (skips lines starting with `%`, they're considered metadata)
# sed '/^% /d' $input | \ 
# lowdown --html-no-head-ids --html-no-escapehtml --html-no-owasp > body.html
# sed '/^%%/,/^%%/'
sed '/^%%/,/^%%/d' $input |\
	lowdown --html-no-head-ids --html-no-escapehtml --html-no-owasp > body.html

# puts id to <h1> tag and adds paragraph next to it with the article-date
sed -i -e 's/<h1>/<h1 id=article-title>/g' \
	-e "s/<\/h1>/<\/h1><p class=\"article-date\">$date (last update $last_update)<\/p>/"\
	body.html

sed -e "s/\$article-title\\$/$title/" -e "s/\$article-date\\$/$date/" \
	-e "s/\$pagetitle\\$/$pagetitle/" -e '/\$body\$/r./body.html' \
	-e "s/\$lang\\$/$lang/" -e "s/\$generator\\$/$generator/" \
	-e '/\$body\$/d' $template > "$dest_dir"/"$filename".html

logo_line=$(grep -zoP '<img.*?("article-icon").*?>' "$dest_dir"/"$filename".html | tr -d '\0')
title_line=$(grep -P '<h1.*?(article-title).*?>' "$dest_dir"/"$filename".html | tr -d '\0')

insert_div_article_title_w_logo() {
	logo_line="$1"
	title_line="$2"

	div_article_title_w_logo "$logo_line" "$title_line"

	sed -i -e "s^$title_line^\
\	<div id=\"article-title-with-icon\">\
\	<div id=\"article-icon\">\
\	<img src=\"$logo_src\" title=\"$logo_title\" alt=\"$logo_alt\">\
\	<\/div>\
\	<h1 id=\"article-title\">$h1_title<\/h1>\
\	<\/div>\
\	<p class=\"article-date\">$date (last update $last_update)</p>^"\
	"$dest_dir"/"$filename".html

	sed -i -E '/(^<p>).*?(article-icon).*?<\/p>/d' "$dest_dir"/"$filename".html
}

[ ! -z "$logo_line" ] && \
	insert_div_article_title_w_logo "$logo_line" "$title_line"

rm -v body.html &> /dev/null

./scripts/syntax-highlight "$dest_dir"/"$filename".html > tmp.html

cp -v ./favicon.webp "$dest_dir"/

mv -v tmp.html "$dest_dir"/index.html

echo "==> "$filename".html generated succesfully"
echo ""
