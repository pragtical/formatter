# Formatters for [Pragtical](https://github.com/pragtical/pragtical)

## List of formatters (Keep alphabetical)
- [black python formatter](https://pypi.org/project/black/)
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
- [cmake-format](https://github.com/cheshirekow/cmake_format)
- [css-beautify](https://www.npmjs.com/package/js-beautify)
- [dartformat](https://dart.dev/tools/dart-format)
- [dfmt](https://github.com/dlang-community/dfmt)
- [esformatter](https://github.com/millermedeiros/esformatter/)
- [gdformat](https://github.com/Scony/godot-gdscript-toolkit)
- [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)
- [html-beautify](https://www.npmjs.com/package/html-beautify)
- [js-beautify](https://www.npmjs.com/package/js-beautify)
- [juliaformat](https://github.com/domluna/JuliaFormatter.jl)
- [luaformatter](https://github.com/Koihik/LuaFormatter)
- [qmlformat](https://github.com/qt/qtdeclarative)
- [rustfmt](https://github.com/rust-lang/rustfmt)
- [shformat](https://github.com/mvdan/sh)
- [styluaformat](https://github.com/JohnnyMorganz/StyLua)
- [tidy](https://www.html-tidy.org/)
- [tsformat](https://github.com/vvakame/typescript-formatter)
- [zigfmt](https://ziglang.org)

## Installation instructions

1. Clone this repository into the pragtical `plugins/formatter` folder

2. Make sure you have the command that formatter uses installed, or it won't work.

3. Extra configuration:
    If you want to customize a formatter, you can do this from your `init.lua`
    script. Example:
```lua
config.plugins.formatter.jsbeautify = {
    -- Optionally disable this formmater
    enabled = false,
    -- Optionally set path of executable
    path = "/path/to/js-beautify",
    -- Set jsBeautify arguments to indent with spaces.
    args = "-r -s 4 -p -b end-expand"
}
```

## Using the formatter
the default keymap to format the current doc is `alt+shift+f`
the command is `formatter:format-doc`

to format a document at each save add the following config to
your user `init.lua` as shown:
```lua
config.plugins.formatter.format_on_save = true
```

## Contributing a formatter

Example from `jsbeautify.lua`:
```lua
-- for JS Beautify fortmatter

return {
  label = "JS Beautifier",
  file_patterns = {"%.js$"},
  command = {"js-beautify", "$ARGS", "$FILENAME"},
  -- make sure to keep -r arg if you change this
  args = "-r -q -s 1 -t -p -b end-expand"
}
```

### a few things to keep in mind
- choose a unique file name
- make sure to set a label
- make sure to add it to the list in readme.md (and keep it alphabetical)

### Then, submit a pull request
