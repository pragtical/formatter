-- for Google Java Formatter

return {
  label = "Google Java Format",
  file_patterns = {"%.java$"},
  command = {"google-java-format", "$ARGS", "$FILENAME"},
  args = "--replace"
}
