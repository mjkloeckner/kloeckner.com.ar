#!/bin/sh

root_folder="/home/mk/soydev/webp/kloeckner.com.ar"
blog_folder="blog"
blog_index_file="blog_index.shtml"
latest_uploads_file="latest_uploads.shtml"
rss_feed_file=$root_folder/"rss.xml"   # RSS feed file

generate_blog_index() {
	rm $root_folder/$blog_index_file 2> /dev/null
	touch $root_folder/$blog_index_file

	for i in $(./sort_blog_index.py /home/mk/soydev/webp/tmp/html/blog/); do
		article_date=$(cat $i | grep -oP '(?<=<meta name="article-date" content=")(.*?)(?=")')
		article_title=$(cat $i | grep -oP '(?<=<meta name="article-title" content=")(.*?)(?=")')

		file_name=$(echo "$i" | grep -oE '[^/]*$' | cut -d '.' -f 1)

		printf "<li><time>%s</time> <a href=\"/$blog_folder/$file_name/$file_name.html\">%s</a></li>\n" "${article_date}" "${article_title}" >> $root_folder/$blog_index_file
    done
}

generate_latest_uploads() {
	rm $root_folder/$latest_uploads_file &> /dev/null

	tail -n 5 $root_folder/$blog_index_file > $root_folder/$latest_uploads_file
}

generate_rss_feed() {
	rm $rss_feed_file 2> /dev/null

    cp rss_feed_top.xml $rss_feed_file
	printf "<lastBuildDate>%s</lastBuildDate>\n" "$(date)" >> $rss_feed_file

	for i in $(./sort_blog_index.py /home/mk/soydev/webp/tmp/html/blog/); do
		article_date=$(cat $i | grep -oP '(?<=<meta name="article-date" content=")(.*?)(?=")')
		article_title=$(cat $i | grep -oP '(?<=<meta name="article-title" content=")(.*?)(?=")')
		file_name=$(echo "$i" | grep -oE '[^/]*$' | cut -d '.' -f 1)

		article_description="$(md2html $root_folder/md/$file_name/$file_name.md | sed -E -e 's/ \(last\ update//g' -e 's/\{[^\}]*\}//g' -e 's/<code>|<\/code>//g' -e 's/<em>|<\/em>//g')"
		rm $root_folder/$blog_folder/$file_name/$file_name.md

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
    for i in $(ls $root_folder/$blog_folder); do
		# if exists and it's a directory
        if [ -d $root_folder/$blog_folder/$i ]; then
			last_modified=$(stat $root_folder/$blog_folder/$i/$i.html --format "%Y")
			rss_file_date=$(stat $rss_feed_file --format "%Y")

			if [ $last_modified -gt $rss_file_date ]
			then
				echo "==> $i.html is newer than $rss_feed_file"
				echo "+ Regenerating rss feed"
				generate_rss_feed
				break
			fi
        fi
    done
}

[ ! -d $root_folder ] && echo "error: root_folder: $root_folder not found" && exit 1

echo "* root_folder: $root_folder"
echo "* blog_folder: $blog_folder"
echo "* blog_index_file: $blog_index_file"
echo "* latest_uploads_file: $latest_uploads_file"
echo "* rss_feed_file: $rss_feed_file"
echo ""
echo "+ generate_blog_index"
generate_blog_index

echo "+ generate_latest_uploads"
generate_latest_uploads

case "$1" in
	--force-rss) echo "+ generate_rss_feed"; generate_rss_feed;;
	*) echo "==> Checking if rss feed needs to be rebuild"; check_rss_feed_last_build;;
esac

set -xe

chown mk:mk $root_folder/$latest_uploads_file

rm -rf /var/www/html 2>/dev/null

cp -rf $root_folder /var/www/html

rm /var/www/html/{rss_feed_top.xml,README.md}

systemctl restart nginx
