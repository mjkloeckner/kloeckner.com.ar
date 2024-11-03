var file;
fetch('/common/blog_index.shtml')
	.then(response => response.text())
	.then((data) => {
		let parser = new DOMParser();
		let doc = parser.parseFromString(data, 'text/html');

		// var match = data.match(/\r?\n/g);
		// alert(match.length);
		var content = document.getElementById('blog-entries');
		var count = doc.getElementById("blog-index-table").rows.length;
		content.innerHTML += " (" + count + ")";
	})

