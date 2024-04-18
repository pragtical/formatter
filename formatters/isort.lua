-- for Isort python formatter

return {
  label = "Isort",
  file_patterns = {"%.pyi?$"},
  command = {"isort", "$ARGS", "$FILENAME"}
}
