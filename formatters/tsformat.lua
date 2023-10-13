-- for TypeScript fortmatter

return {
	label = "TS Formatter",
	file_patterns = { "%.tsx$", "%.ts$" },
	command = { "tsfmt", "$ARGS", "$FILENAME" },
	-- make sure to keep -r arg if you change this
	args = "-r --no-vscode",
}
