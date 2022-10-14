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

# TODO: ...
apply_syntax_highlight() {
	commands=("make" "cat" "grep" "sed")
	ul_commands=("sudo")

	# Requires GNU grep
	grep -zoP '<code.*>(.|\n)*?<\/code>' $1
	for i in ${commands[@]}; do
		echo $i
	done
	for i in ${ul_commands[@]}; do
		echo $i
	done
}

div_article_title_w_logo() {
	# convert:
	# 	<p><img src="vim_logo.png" alt="Vim logo" class="article-icon" title="Vim logo" /></p>
	# 	<h1>The keyboard driven text editor</h1>

	# into:
	# 	<div id="article-title-with-icon">
	# 		<div id="article-icon">
	# 			<img src="/blog/vim-config/vim_logo.png" title="Vim logo" alt="Vim logo">
	# 		</div>
	# 		<h1 id="article-title">The keyboard driven text editor</h1>
	# 	</div>

	# if found a `class="article-icon"` then put a div around it including
	# title with logo, for styling purposes
	# <img src="vim_logo.png" alt="Vim logo" class="article-icon" title="Vim logo" />
	logo_src=$(echo $1 | grep -zoP '(?<=src=\")(.*?)(?=\")')
	logo_alt=$(echo $1 | grep -zoP '(?<=alt=\")(.*?)(?=\")')
	logo_title=$(echo $1 | grep -zoP '(?<=title=\")(.*?)(?=\")')
	h1_title=

	echo "logo src: $logo_src"
	echo "logo alt: $logo_alt"
	echo "logo title: $logo_title"
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
			t) templ="$OPTARG"; echo "template: $templ";;
			d) dest_dir="$OPTARG";;
			\?) printf "%s\n\n" "error: flag not found" && usage && exit 1;;
		esac
	done

	[ $OPTIND -eq 1 ] && missing_operand && exit 2
	shift "$((OPTIND-1))"

	[ -z "$input" ] || [ ! -e "$input" ] && echo "error: no input file" && exit 1
	[ -z "$templ" ] || [ ! -e "$templ" ] && echo "error: no template file" && exit 1
	[ -z "$dest_dir" ] && dest_dir="."
}

check_opt $@

title=$(cat $input | head -n 3 | grep -oP '(?<=% title: \")(.*?)(?=\")')
date=$(cat $input | head -n 3 | grep -oP '(?<=% date: \")(.*?)(?=\")')
pagetitle="Martin Klöckner's Webpage"
lang="en"
generator="Shell script"
template="$templ"
filename="$(basename $input | sed 's/\.[^.]*$//')"

echo "file: $input"
echo "filename: $filename"
echo "title: $title"
echo "date: $date"
echo "dest dir: $dest_dir"
echo "template: $template"

# generate body (skips lines starting with `%`, they're considered metadata)
sed '/^% /d' $input | lowdown --html-no-head-ids --html-no-escapehtml --html-no-owasp > body.html

# puts ids to <h1> tag and adds paragraph next to it with the article-date
sed -i -e 's/<h1>/<h1 id=article-title>/g' \
	-e "s/<\/h1>/<\/h1><p class=\"article-date\">"$date"<\/p>/" body.html

# indent: sed + `-e 's/^/\t\t\t/'`
# (applying indent makes final html more pleasant to view, but causes code
#     block to not be displayed properly)

sed -e "s/\$article-title\\$/$title/" -e "s/\$article-date\\$/$date/" \
	-e "s/\$pagetitle\\$/$pagetitle/" -e '/\$body\$/r./body.html' \
	-e "s/\$lang\\$/$lang/" -e "s/\$generator\\$/$generator/" \
	-e '/\$body\$/d' $template > "$dest_dir"/"$filename".html

# logo_line=$(grep -zoP '<img.*?("article-icon").*?>')
# [ "$?" -eq "0" ] && div_article_title_w_logo logo_line $(grep -zoP )

rm body.html &> /dev/null

# ./syntax-highlight "$dest_dir"/"$filename".html > sh.html

# cp -rf sh.html "$dest_dir"/"$filename".html

echo "==> "$dest_dir"/"$filename".html generated succesfully"
echo ""

# apply_syntax_highlight "$filename.html"
