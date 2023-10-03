-- for Dart formatter

return {
  label = "Dart Formatter",
  file_patterns = {"%.dart$"},
  command = {"dart", "format", "$ARGS", "$FILENAME"}
}
