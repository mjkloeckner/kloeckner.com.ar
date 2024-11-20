
function toggleColorScheme() {
	const dataTheme = document.documentElement.getAttribute("data-theme");
	const systemDarkMode = window.matchMedia("(prefers-color-scheme: dark)").matches;

	if(typeof dataTheme == "undefined" || dataTheme === null) {
		newTheme = systemDarkMode ? "light" : "dark";
	} else {
		newTheme = (dataTheme === "dark") ? "light" : "dark";
	}

	document.documentElement.setAttribute("data-theme", newTheme);
	localStorage.setItem("data-theme", newTheme);
	updateColorSchemeButton()

	if(((newTheme === "dark") && systemDarkMode) || ((newTheme === "light") && !systemDarkMode)) {
		console.log("Removing item");
		localStorage.removeItem("data-theme");
	}
}

function updateColorSchemeButton() {
	const dataTheme = localStorage.getItem("data-theme");
	const systemDarkMode = window.matchMedia("(prefers-color-scheme: dark)").matches;
	const colorSchemeButtonLight = document.getElementById("color-scheme-button-light");
	const colorSchemeButtonDark = document.getElementById("color-scheme-button-dark");

	function buttonDarkMode() {
		colorSchemeButtonLight.style.display = "none";
		colorSchemeButtonDark.style.display = "inline-block";
		document.documentElement.setAttribute("data-theme", "dark");
	}

	function buttonLightMode() {
			colorSchemeButtonLight.style.display = "inline-block";
			colorSchemeButtonDark.style.display = "none";
			document.documentElement.setAttribute("data-theme", "light");
	}

	if(typeof dataTheme == "undefined" || dataTheme === null) {
		if(systemDarkMode) {
			buttonDarkMode();
		} else {
			buttonLightMode();
		}
	} else {
		if(dataTheme === "dark") {
			buttonDarkMode();
		} else {
			buttonLightMode();
		}
	}
}

function removeLocalStorage() {
	console.log("Removing item");
	localStorage.removeItem("data-theme");
	updateColorSchemeButton();
}

window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", removeLocalStorage);
window.matchMedia("(prefers-color-scheme: light)").addEventListener("change", removeLocalStorage);
updateColorSchemeButton()
