-- For the prettier formatter

return {
  label = "Prettier",
  file_patterns = {"%.less$", "%.scss$", "%.json$", "%.jsx?$", "%.ts$"},
  command = {"npx", "prettier", "$ARGS", "$FILENAME"},
  args = "-w"
}
