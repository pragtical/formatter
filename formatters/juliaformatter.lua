-- for JuliaFormatter formatter

return {
  label = "JuliaFormatter",
  file_patterns = {"%.jl$", "%.julia$"},
  command = {
    "julia",
    "--compile=min",
    "-e",
    "$ARGS",
    "'import JuliaFormatter: format_file; format_file($FILENAME)'"
  },
}
