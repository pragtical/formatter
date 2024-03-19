-- for V vfmt formatter

return {
  label = "vfmt",
  file_patterns = {"%.vv?$", "%.vsh$"},
  command = {"v", "fmt", "$ARGS", "$FILENAME"},
  args = "-w"
}
