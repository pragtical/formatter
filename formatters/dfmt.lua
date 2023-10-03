-- for dfmt dlang formatter

return {
  label = "DLang Formatter",
  file_patterns = {"%.d$"},
  command = {"dfmt", "$FILENAME", "$ARGS"},
  args = "--brace_style=otbs --indent_size=2 --inplace"
}
