-- For phpcbf PHP formatter

return {
  label = "PHP CodeSniffer Beautifier",
  file_patterns = {"%.php$"},
  command = {"phpcbf", "$ARGS", "$FILENAME"}
}
