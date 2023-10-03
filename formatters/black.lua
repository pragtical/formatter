-- for Black python formatter

return {
  label = "Black",
  file_patterns = {"%.py$"},
  command = {"black", "$ARGS", "$FILENAME"}
}
