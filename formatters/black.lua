-- for Black python formatter

return {
  label = "Black",
  file_patterns = {"%.pyi?$"},
  command = {"black", "$ARGS", "$FILENAME"}
}
