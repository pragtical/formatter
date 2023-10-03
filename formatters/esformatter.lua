-- for esformatter fortmatter

return {
  label = "ESFormatter",
  file_patterns = {"%.js$"},
  command = {"esformatter", "$ARGS", "$FILENAME"},
  -- default arguments. if you change them, make sure to include -i or it won't work
  args = "-i --indent-value=\"\\t\""
}
