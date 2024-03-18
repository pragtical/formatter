-- for Clojure cljfmt

return {
  label = "cljfmt",
  file_patterns = {"%.clj$"},
  command = {"cljfmt", "$ARGS", "$FILENAME"},
  args = "check fix"
}
