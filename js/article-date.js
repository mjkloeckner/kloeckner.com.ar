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
