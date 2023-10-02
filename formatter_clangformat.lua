-- mod-version:3
-- for ClangFormat formatter
local config = require "core.config"
local formatter = require "plugins.formatter"

config.clangformat_args = {"--style=file", "--fallback-style=WebKit", "-i"}

formatter.add_formatter {
	name = "ClangFormat",
	file_patterns = {
		"%.h$", "%.c", "%.inl$", "%.cpp$", "%.cc$", "%.C$", "%.cxx$",
    "%.c++$", "%.hh$", "%.H$", "%.hxx$", "%.hpp$", "%.h++$"
	},
	command = "clang-format $ARGS $FILENAME",
	args = config.clangformat_args
}
