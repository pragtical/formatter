-- for LuaFormatter fortmatter

return {
	label = "LuaFormatter",
	file_patterns = {"%.lua$"},
	command = {"lua-format", "$ARGS", "$FILENAME"},
	-- make sure to keep -i arg if you change this
	args = "-i --use-tab --indent-width=1"
}
