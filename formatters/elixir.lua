-- for mix Elixir formatter

return {
  label = "Elixir",
  file_patterns = {"%.exs?$"},
  command = {"mix", "format", "$ARGS", "$FILENAME"}
}
