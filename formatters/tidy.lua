-- for tidy fortmatter

return {
  label = "Tidy HTML/XHTML/XML prettifier",
  file_patterns = {"%.html$", "%.xml$"},
  command = {"tidy", "$ARGS", "$FILENAME"},
  args = "-indent -modify --tidy-mark no -quiet -utf8"
}
