-- for JS Beautify fortmatter

return {
  label = "JS Beautifier",
  file_patterns = {"%.js$"},
  command = {"js-beautify", "$ARGS", "$FILENAME"},
  -- make sure to keep -r arg if you change this
  args = "-r -q -s 1 -t -p -b end-expand"
}
