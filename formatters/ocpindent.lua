-- for OCaml ocp-indent formatter

return {
  label = "ocp-indent",
  file_patterns = {"%.ml$"},
  command = {"ocp-indent", "$ARGS", "$FILENAME"},
  args = "-i"
}
