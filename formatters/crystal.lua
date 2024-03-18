-- for the official Crystal formatter

return {
  label = "Crystal",
  file_patterns = {"%.cr$"},
  command = {"crystal", "tool", "format", "$ARGS", "$FILENAME"}
}
