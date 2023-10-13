-- for StyluaFormatter fortmatter

return {
	label = "StyluaFormatter",
	file_patterns = { "%.lua$" },
	command = { "stylua", "$ARGS", "$FILENAME" },
	-- make sure to keep -i arg if you change this
	args = "-a",
}
