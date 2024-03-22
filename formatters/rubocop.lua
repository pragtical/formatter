-- for Ruby Rubocop formatter

return {
  label = "Rubocop",
  file_patterns = {"%.rb$"},
  command = {"rubocop", "$ARGS", "$FILENAME"},
  args = "-p -A"
}
