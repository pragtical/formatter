-- for SQL sql-formatter

return {
  label = "sql-formatter",
  file_patterns = {"%.sql$"},
  command = {"sql-formatter", "$ARGS", "$FILENAME"},
  args = "--fix"
}
