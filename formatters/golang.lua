-- for Golang fortmatter

return {
  label = "Golang Formatter",
  file_patterns = {"%.go$"},
  command = {"goimports", "$ARGS", "$FILENAME"},
  args = "-w"
}
