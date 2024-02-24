var file;
fetch('/common/blog_index.shtml')
	.then(response => response.text())
	.then((data) => {
		var match = data.match(/\r?\n/g);
		// alert(match.length);
		var content = document.getElementById('blog-entries');
		content.innerHTML += " (" + match.length + ")";
	})
