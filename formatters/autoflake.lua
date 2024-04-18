-- for autoflake python formatter

return {
  label = "Autoflake",
  file_patterns = {"%.pyi?$"},
  command = {"autoflake", "$ARGS", "$FILENAME"},
  args = "--remove-all-unused-imports --remove-unused-variables --remove-duplicate-keys --expand-star-imports -ir"
}
