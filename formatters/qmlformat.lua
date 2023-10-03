-- for qmlformat formatter

return {
  label = "QmlFormat",
  file_patterns = {"%.qml$"},
  command = {"qmlformat", "$ARGS", "$FILENAME"},
  args = "-i"
}
