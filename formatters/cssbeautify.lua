-- for CSS Beautify fortmatter

return {
  label = "CSS Beautifier",
  file_patterns = {"%.css$"},
  command = {"css-beautify", "$ARGS", "$FILENAME"},
  args = "-r -q -s 1 -t" -- make sure to keep -r arg if you change this
}
