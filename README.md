# Formatters for [Pragtical](https://github.com/pragtical/pragtical)

## List of formatters (Keep alphabetical)
- [autoflake python formatter](https://pypi.org/project/autoflake/)
- [black python formatter](https://pypi.org/project/black/)
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
- [cljfmt](https://github.com/weavejester/cljfmt)
- [cmake-format](https://github.com/cheshirekow/cmake_format)
- [csharpier](https://github.com/belav/csharpier)
- [crystal](https://man.archlinux.org/man/crystal.1.en)
- [css-beautify](https://www.npmjs.com/package/js-beautify)
- [dartformat](https://dart.dev/tools/dart-format)
- [dfmt](https://github.com/dlang-community/dfmt)
- [elixir](https://hexdocs.pm/mix/main/Mix.Tasks.Format.html)
- [elm-format](https://github.com/avh4/elm-format)
- [esformatter](https://github.com/millermedeiros/esformatter/)
- [gdformat](https://github.com/Scony/godot-gdscript-toolkit)
- [google-java-format](https://github.com/google/google-java-format)
- [goimports](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)
- [html-beautify](https://www.npmjs.com/package/html-beautify)
- [isort python formatter](https://pypi.org/project/isort/)
- [js-beautify](https://www.npmjs.com/package/js-beautify)
- [juliaformat](https://github.com/domluna/JuliaFormatter.jl)
- [luaformatter](https://github.com/Koihik/LuaFormatter)
- [ocp-indent](https://github.com/OCamlPro/ocp-indent)
- [ormolu](https://github.com/tweag/ormolu)
- [perltidy](https://github.com/perltidy/perltidy)
- [phpcbf](https://github.com/PHPCSStandards/PHP_CodeSniffer)
- [prettier](https://github.com/prettier/prettier)
- [qmlformat](https://github.com/qt/qtdeclarative)
- [rubocop](https://github.com/rubocop/rubocop)
- [ruff](https://docs.astral.sh/ruff/formatter)
- [rustfmt](https://github.com/rust-lang/rustfmt)
- [shformat](https://github.com/mvdan/sh)
- [sql-formatter](https://github.com/sql-formatter-org/sql-formatter)
- [styluaformat](https://github.com/JohnnyMorganz/StyLua)
- [tidy](https://www.html-tidy.org/)
- [tsformat](https://github.com/vvakame/typescript-formatter)
- [vfmt](https://github.com/vlang/v)
- [zigfmt](https://ziglang.org)

## Installation instructions

1. Clone this repository into the pragtical `plugins/formatter` folder

2. Make sure you have the command that formatter uses installed, or it won't work.

3. Extra configuration:
    If you want to customize a formatter, you can do this from your `init.lua`
    script. Example:
```lua
local formatter = require("plugins.formatter")

formatter.config("jsbeautify", {
    -- Optionally disable this formmater
    enabled = false,
    -- Optionally set path of executable
    path = "/path/to/js-beautify",
    -- Set jsBeautify arguments to indent with spaces.
    args = "-r -s 4 -p -b end-expand"
})
```

4. You can also enable/disable and configure all available formatters from the
   settings graphical interface on Plugins -> Formatter.

## Formatter plugin public API

```lua
local formatter = require("plugins.formatter")

---Represents a registered formatter.
---@class plugins.formatter.formatter
---@field name string
---@field label string
---@field enabled boolean?
---@field file_patterns string[]
---@field command string[]
---@field args? string

---Register a new formatter.
---@param f plugins.formatter.formatter
function formatter.add_formatter(f)

---Modify a registered formatter configuration.
---@param name string
---@param options plugins.formatter.formatter
---@return boolean modified
function formatter.config(name, options)

---Get a formatter by its name.
---@param name string
---@return plugins.formatter.formatter?
function formatter.get(name)

---Get the first formatter that matches the given filename and is enabled.
---@param filename string
---@return plugins.formatter.formatter?
function formatter.get_by_filename(filename)
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

### A few things to keep in mind
- choose a unique file name
- make sure to set a label
- make sure to add it to the list in readme.md (and keep it alphabetical)

### Then, submit a pull request
