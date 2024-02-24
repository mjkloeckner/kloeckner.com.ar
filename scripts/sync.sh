#!/bin/sh

root_folder="$(pwd)"
blog_folder="blog"
html_folder="blog"
blog_index_file="common/blog_index.shtml"
latest_uploads_file="common/latest_uploads.shtml"
rss_feed_file=$root_folder/"rss.xml"   # RSS feed file
blog_folders=$("$root_folder"/scripts/sort_blog_index.py "$blog_folder")
index_latest_uploads_count=6

generate_blog_index() {
	update=false
	for i in $(ls $root_folder/$blog_folder); do
		# if exists and it's a directory
		if [ -d $root_folder/$blog_folder/$i ]; then
			last_modified=$(stat $root_folder/$blog_folder/$i/$i.md --format "%Y")
			blog_index_file_date=$(stat $blog_index_file --format "%Y")

			if [ $last_modified -gt $blog_index_file_date ]
			then
				echo "     └─ $i.html is newer than $blog_index_file"
				echo "+ Regenerating blog index file"
				update=true
				break
			fi
		fi
	done

	[ ! -z "$1" ] && update=true;
	[ "$update" = "false" ] && echo \"     └─ Blog index file up to date\" && return 1
	echo "     └─ Updating blog index"

	rm -rf $root_folder/$blog_index_file ||:
	touch $root_folder/$blog_index_file

	for i in ${blog_folders[@]}; do
		# deprecated format
		# article_date=$(cat $i | grep -oP '(?<=% date: \")(.*?)(?=\")')
		# article_title=$(cat $i | grep -oP '(?<=% title: \")(.*?)(?=\")')
		article_date=$(cat $i | sed '/^%%/,/^%%/!d' | grep -oP '(?<=date: \")(.*?)(?=\")')
		article_title=$(cat $i | sed '/^%%/,/^%%/!d' | grep -oP '(?<=title: \")(.*?)(?=\")')
		[ -z "$article_title" ] || [ -z "$article_date" ] && echo "error: no metadata found on file $input" && exit 1

		file_name=$(echo "$i" | grep -oE '[^/]*$' | cut -d '.' -f 1)

		printf "<li><b-time>%s</b-time> <a href=\"/$blog_folder/$file_name/$file_name.html\">%s</a></li>\n" \
			"${article_date}" "${article_title}" >> $root_folder/$blog_index_file
	done
}

generate_latest_uploads() {
	rm -rf $root_folder/$latest_uploads_file ||:

	head -n $index_latest_uploads_count $root_folder/$blog_index_file > $root_folder/$latest_uploads_file
}

generate_rss_feed() {
	rm $rss_feed_file &> /dev/null

	cp "$root_folder"/scripts/rss_feed_top.xml $rss_feed_file
	printf "<lastBuildDate>%s</lastBuildDate>\n" "$(date)" >> $rss_feed_file

	for i in ${blog_folders[@]}; do
		# article_date=$(cat $i | grep -oP '(?<=<meta name="article-date" content=")(.*?)(?=")')
		# article_title=$(cat $i | grep -oP '(?<=<meta name="article-title" content=")(.*?)(?=")')
		# deprecated format
		# article_date=$(cat $i | grep -oP '(?<=% date: \")(.*?)(?=\")')
		# article_title=$(cat $i | grep -oP '(?<=% title: \")(.*?)(?=\")')

		article_date=$(cat $i | sed '/^%%/,/^%%/!d' | grep -oP '(?<=date: \")(.*?)(?=\")')
		article_title=$(cat $i | sed '/^%%/,/^%%/!d' | grep -oP '(?<=title: \")(.*?)(?=\")')
		[ -z "$article_title" ] || [ -z "$article_date" ] && echo "error: no metadata found on file $input" && exit 1

		file_name=$(echo "$i" | grep -oE '[^/]*$' | cut -d '.' -f 1)

		article_description="$(sed '/^%%/,/^%%/d' $root_folder/md/$file_name/$file_name.md | md2html |\
			sed -E -e 's/ \(last\ update//g' -e 's/\{[^\}]*\}//g'\
			       -e 's/<code>|<\/code>//g' -e 's/<em>|<\/em>//g')"

		# Create RSS feed item
		echo "<item>" >> $rss_feed_file
		echo "<title>$article_title</title>" >> $rss_feed_file
		echo "<link>https://kloeckner.com.ar/blog/$file_name/$file_name.html</link>" >> $rss_feed_file
		echo "<description>
				<htmlData>
					<![CDATA[<html>$article_description</html>]]>
				</htmlData>
			</description>" >> $rss_feed_file
		echo "<pubDate>$article_date</pubDate>" >> $rss_feed_file
		echo "$article_date"
		echo "</item>" >> $rss_feed_file
		echo "" >> $rss_feed_file
	done

	# Close the RSS feed file
	echo "" >> $rss_feed_file
	echo "</channel>" >> $rss_feed_file
	echo "</rss>" >> $rss_feed_file
}

check_rss_feed_last_build() {
	[ ! -e $rss_feed_file ] && echo "+ Regenerating rss feed" && generate_rss_feed && return
	updated=false
	for i in $(ls $root_folder/$blog_folder); do
		# if exists and it's a directory
		if [ -d $root_folder/$blog_folder/$i ]; then
			last_modified=$(stat $root_folder/$blog_folder/$i/$i.md --format "%Y")
			rss_file_date=$(stat $rss_feed_file --format "%Y")

			if [ $last_modified -gt $rss_file_date ]
			then
				echo "     └─ $i.html is newer than $rss_feed_file"
				echo "+ Regenerating rss feed"
				generate_rss_feed && updated=true
				break
			fi
		fi
	done
	$updated || echo "     └─ Rss feed file up to date" && echo ""
}

[ ! -d $root_folder ] && \
	echo "error: root_folder: $root_folder not found" && exit 1

echo "* root_folder: $root_folder"
echo "* blog_folder: $blog_folder"
echo "* blog_index_file: $blog_index_file"
echo "* latest_uploads_file: $latest_uploads_file"
echo "* rss_feed_file: $rss_feed_file"
echo "+ generate_blog_index"
generate_blog_index

if [ $? -eq 1 ]; then
	echo "+ generate_latest_uploads"
	generate_latest_uploads
else
	echo "+ generate_latest_uploads"
	echo "     └─ Index file up to date"
fi

case "$1" in
	--force-update) 
		echo "+ generate_rss_feed"; generate_rss_feed;
		echo "+ generate_blog_index"; generate_blog_index "force-update";;
	*) echo "+ check_rss_feed_last_build"; check_rss_feed_last_build;;
esac
