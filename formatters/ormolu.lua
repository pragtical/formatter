-- for Ormolu Haskell formatter

return {
  label = "Ormolu",
  file_patterns = {"%.hs$"},
  command = {"ormolu", "$ARGS", "$FILENAME"},
  args = "--mode inplace"
}
