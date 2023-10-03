-- for HTML Beautify fortmatter

return {
  label = "HTML Beautifier",
  file_patterns = {"%.html$"},
  command = {"html-beautify", "$ARGS", "$FILENAME"},
  args = "-r -q -s 1 -t -I" -- make sure to keep -r arg if you change this
}
