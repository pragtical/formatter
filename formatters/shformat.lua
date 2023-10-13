-- for Shell fortmatter

return {
	label = "Sh Formatter",
	file_patterns = {"%.sh$","%.bash$","%.zsh$",".bashrc"},
	command = {"shfmt", "$ARGS", "$FILENAME"},
	-- make sure to keep -w arg if you change this
	args = "-w -s"
}
