-- for Rust fortmatter

return {
	label = "Rust Formatter",
	file_patterns = {"%.rs$"},
	command = {"rustfmt", "$ARGS", "$FILENAME"}
}
