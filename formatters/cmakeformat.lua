-- for CMake Formatter

return {
  label = "CMake Format",
  file_patterns = {"%.cmake$", "CMakeLists.txt$"},
  command = {"cmake-format", "$ARGS", "$FILENAME"},
  args = "-i" -- Since by default, the output is stdout
}
