-- for the Janet janet-format formatter

return {
  label = "Janet Format",
  file_patterns = {"%.janet", "%.jdn"},
  command = {"janet-format", "$ARGS", "--files", "$FILENAME"}
}
