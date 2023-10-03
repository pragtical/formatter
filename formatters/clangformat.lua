-- for ClangFormat formatter

return {
  label = "Clang Format",
  file_patterns = {
    "%.h$", "%.c", "%.inl$", "%.cpp$", "%.cc$", "%.C$", "%.cxx$",
    "%.c++$", "%.hh$", "%.H$", "%.hxx$", "%.hpp$", "%.h++$"
  },
  command = {"clang-format", "$ARGS", "$FILENAME"},
  args = "--style=file --fallback-style=WebKit -i"
}
