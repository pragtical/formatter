-- for C# csharpier formatter

return {
  label = "csharpier",
  file_patterns = {"%.cs$"},
  command = {"dotnet-csharpier", "$ARGS", "$FILENAME"}
}
