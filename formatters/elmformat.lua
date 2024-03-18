-- for Elm formatter

return {
  label = "Elm",
  file_patterns = {"%.elm$"},
  command = {"elm-format", "$ARGS", "$FILENAME"},
  args = "--yes"
}
