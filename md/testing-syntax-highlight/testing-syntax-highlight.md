% title: "Testing code syntax highlight"
% date: "21-Oct-2022"

# Testing code syntax highlight

This is a testing page for a script that I'm using to highlight
code blocks within an html file.

The script is a heavily modified version of [markdown-code-highlight-go](https://github.com/zupzup/markdown-code-highlight-go)
that accepts an html file name as command line argument, and prints
to stdout the html content but with all text inside code tags surrounded
by css selectors.

For example, this is some C code:

```c
#include <stdio.h>

int main(void) {
	char *hw = "Hello, world!\n";

	printf("%s\n", hw);
	return 0;
}
```

This is part of the shell script that I use to build the html blog pages
from markdown files

```console
sed -e "s/\$article-title\\$/$title/" -e "s/\$article-date\\$/$date/" \
	-e "s/\$pagetitle\\$/$pagetitle/" -e '/\$body\$/r./body.html' \
	-e "s/\$lang\\$/$lang/" -e "s/\$generator\\$/$generator/" \
	-e '/\$body\$/d' $template > "$dest_dir"/"$filename".html
```

This is an old JavaScript script that I was using to add the last modified date to a blog
post:

```js
// https://stackoverflow.com/questions/3552461/how-do-i-format-a-date-in-javascript
function join(t, a, s) {
   function format(m) {
	  let f = new Intl.DateTimeFormat('en', m);
	  return f.format(t);
   }
   return a.map(format).join(s);
}

var dt = new Date(document.lastModified);

let format = [{day: 'numeric'}, {month: 'short'}, {year: 'numeric'}];
let dts = join(dt, format, '-');

document.querySelector('.article-date').innerHTML += " (last updated " + dts + ")";
```
I removed it from the webpage because it was not working properly, the \`document.lastModified\`
was always returning the current date. In stead, I added a new part to the shell script that
builds the pages, the new content parses the output of \`stat\` command and appends it to the article date.

This code is part of the script that I'm using for highlighting code blocks. It's written in
golang, a language that I didn't knew until I needed to modify [markdown-code-highlight-go](https://github.com/zupzup/markdown-code-highlight-go) to make it work on my use case.

```go
rp := strings.NewReplacer("<code class=\"language-", "", "\">", "", "</code>", "")

style := styles.Get("monokai")
if style == nil {
	style = styles.Fallback
}

formatter := formatters.Get("html")
if formatter == nil {
	formatter = formatters.Fallback
}
```

This part is using the [chroma](https://github.com/alecthomas/chroma) syntax highlighter, at the moment I couldn't make it work, but I would like to, since it's much richer in languages support and themes than the previous method.
