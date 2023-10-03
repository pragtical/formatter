-- for GDFormat from godot-gdscript-toolkit

return {
  label = "GDFormat",
  file_patterns = {"%.gd$"},
  command = {"gdformat", "$ARGS", "$FILENAME"},
}
