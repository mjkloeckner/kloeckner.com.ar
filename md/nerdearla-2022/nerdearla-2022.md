% title: "I'm going to Nerdearla 2022"
% date: "23-Sep-2022"

# I'm going to Nerdearla 2022

As the title says I'm going to be present at [Nerdearla](https://nerdear.la/).

This will be my second time that I attend to this event since I've been there for the first time in 2019. I remember that [John 'Maddog' Hall](https://en.wikipedia.org/wiki/Jon_Hall_(programmer)) was making a presentation called "50 years of UNIX and the landing on the Moon", you can find a record of the presentation [here](https://www.youtube.com/watch?v=9O_FnKZI6_M).

[![Nerdearla 2019](nerdearla-2019.jpeg)](nerdearla-2019.png "Nerdearla 2019")

It was my first talk ever and I loved it, sadly becouse of the pandemic I couldn't go in the past two years.

The event is half remote half presential and the entrance is free. It takes place at Centro cultural Konex on Once, Buenos Aires on Oct 19 to Oct 22, last three days.

```console
$ sudo make clean install
```

This is how I replace the variables in the template with the data aquired from the metadata contained in the files written in markdown

```console
$ sed -e "s/\$article-title\\$/$title/" -e "s/\$article-date\\$/$date/" \
	-e "s/\$pagetitle\\$/$pagetitle/" -e '/\$body\$/r./body.html' \
	-e '/\$body\$/d' $template > $filename.html
```

This is how I generate this webpage, converting it from its markdown file into html, this is a custom scripts that I made that only depends on lowdown, grep, and sed. Previously I had another script similar, which depended on pandoc, which is an alternative of lowdown but much more bloated, it depends on a ton of libraries wirtten in haskell


```console
$ ./build.sh nerdearla-2022.md
```
