-- for ruff python formatter

return {
  label = "Ruff",
  file_patterns = {"%.pyi?$"},
  command = {"ruff", "format", "$ARGS", "$FILENAME"}
}
