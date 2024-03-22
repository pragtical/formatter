-- for Perl perltidy formatter

return {
  label = "perltidy",
  file_patterns = {"%.pl$"},
  command = {"perltidy", "$ARGS", "$FILENAME"},
  args = "-b -se"
}
