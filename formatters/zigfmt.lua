-- for zig fmt formatter

return {
    label = "zig fmt",
    file_patterns = {"%.zig$"},
    -- zig fmt doesn't need any args when formatting single file
    command = {"zig", "fmt", "$ARGS", "$FILENAME"}
}
