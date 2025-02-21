-- mod-version:3
local core = require "core"
local config = require "core.config"
local command = require "core.command"
local common = require "core.common"
local Doc = require "core.doc"
local DocView = require "core.docview"
local keymap = require "core.keymap"

---@class config.plugins.formatter
---Automatically format documents after each save.
---@field format_on_save boolean
config.plugins.formatter = common.merge({
  format_on_save = false,
  -- The config specification used by the settings gui
  config_spec = {
    name = "Formatter",
    {
      label = "Format on Save",
      description = "Automatically format documents after each save.",
      path = "format_on_save",
      type = "toggle",
      default = false
    }
  }
}, config.plugins.formatter)

---Represents a registered formatter.
---@class plugins.formatter.formatter
---@field name string
---@field label string
---@field enabled boolean?
---@field file_patterns string[]
---@field command string[]
---@field args? string

---@type plugins.formatter.formatter[]
local formatters = {}

local function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*"..PATHSEP..")")
end

---Corrects the path of commands when using the settings ui.
---@param path string
---@return string path
local function config_fix_path(path)
  if not io.open(path, "rb") then
    path = common.basename(path)
  end
  return path
end

-- Automatically load all available formatters
local list = system.list_dir(script_path() .. "formatters")
if list then
  table.sort(list)
  for _, formatter in ipairs(list) do
    local formatter_name = formatter:gsub("%.lua$", "")
    ---@type plugins.formatter.formatter
    local fmt_obj = require("plugins.formatter.formatters."..formatter_name)
    fmt_obj.name = formatter_name
    fmt_obj.enabled = formatter_name
    table.insert(formatters, fmt_obj)
    table.insert(config.plugins.formatter.config_spec, {
      label = fmt_obj.label .. " Enabled",
      description = "Enable or disable " .. fmt_obj.label .. ".",
      path = fmt_obj.name .. ".enabled",
      type = "toggle",
      default = true
    })
    local command_escaped = fmt_obj.command[1]:gsub("%-", "%%-")
    table.insert(config.plugins.formatter.config_spec, {
      label = fmt_obj.label .. " Executable",
      description = "Path to " .. fmt_obj.label .. " executable.",
      path = fmt_obj.name .. ".path",
      type = "FILE",
      default = fmt_obj.command[1],
      filters = {command_escaped.."$", command_escaped..".exe$"},
      get_value = config_fix_path,
      set_value = config_fix_path,
      on_apply = function(value)
        fmt_obj.command[1] = value
      end
    })
    table.insert(config.plugins.formatter.config_spec, {
      label = fmt_obj.label .. " Arguments",
      description = "Custom command line arguments for "..fmt_obj.label..".",
      path = fmt_obj.name .. ".args",
      type = "STRING",
      default = fmt_obj.args or "",
      on_apply = function(value)
        fmt_obj.args = value
      end
    })
  end
end

-- stolen from linter plugin
local function matches_any(filename, patterns)
  for _, ptn in ipairs(patterns) do if filename:find(ptn) then return true end end
end

---Returns the first formatter that matches, so beware if you
---install multiple for the same file type
---@return plugins.formatter.formatter?
local function get_formatter(filename)
  local formatter = nil
  for _, v in pairs(formatters) do
    local enabled = v.enabled
    if
      config.plugins.formatter[v.name]
      and
      type(config.plugins.formatter[v.name].enabled) == "boolean"
    then
      enabled = config.plugins.formatter[v.name].enabled
    end
    if enabled and matches_any(filename, v.file_patterns) then formatter = v end
  end
  return formatter
end

---Sometimes the autoreload plugin doesn't detect the file change, so we
---need our own reload_doc function to reload document after formatting it.
---@param doc core.doc
local function reload_doc(doc)
  local fp = io.open(doc.abs_filename, "r")
  if not fp then
    core.error("Could not open '%s' for formatting", doc.filename)
    return
  end
  local text = fp:read("*a")
  fp:close()

  -- TODO: check text has changed

  local sel = {doc:get_selection()}
  doc:remove(1, 1, math.huge, math.huge)
  doc:insert(1, 1, text:gsub("\r", ""):gsub("\n$", ""))
  doc:set_selection(table.unpack(sel))

  -- prevent autoreload from kicking in to keep undo history
  doc.skip_format = true
  doc:save()
end

---Split a string by the given delimeter
---@param s string The string to split
---@param delimeter string Delimeter without lua patterns
---@param delimeter_pattern? string Optional delimeter with lua patterns
---@return table
local function split(s, delimeter, delimeter_pattern)
  if not delimeter_pattern then
    delimeter_pattern = delimeter
  end

  local result = {};
  for match in (s..delimeter):gmatch("(.-)"..delimeter_pattern) do
    table.insert(result, match);
  end
  return result;
end

---Check if a file exists.
---@param file_path string
---@return boolean
local function file_exists(file_path)
  local file = io.open(file_path, "r")
  if file ~= nil then
    file:close()
    return true
  end
 return false
end

---Check if a command exists on the system by inspecting the PATH envar.
---@param command string
---@return boolean
local function command_exists(command)
  local command_win = nil

  if PLATFORM == "Windows" then
    if not command:find("%.exe$") then
      command_win = command .. ".exe"
    end
  end

  if
    file_exists(command)
    or
    (command_win and file_exists(command_win))
  then
    return true
  end

  local env_path = os.getenv("PATH")
  local path_list = {}

  if PLATFORM ~= "Windows" then
    path_list = split(env_path, ":")
  else
    path_list = split(env_path, ";")
  end

  -- Automatic support for brew, macports, etc...
  if PLATFORM == "Mac OS X" then
    if
      system.get_file_info("/usr/local/bin")
      and
      not string.find(env_path, "/usr/local/bin", 1, true)
    then
      table.insert(path_list, 1, "/usr/local/bin")
    end
  end

  for _, path in pairs(path_list) do
    local path_fix = path:gsub("[/\\]$", "") .. PATHSEP
    if file_exists(path_fix .. command) then
      return true
    elseif command_win and file_exists(path_fix .. command_win) then
      return true
    end
  end

  return false
end

---Formats current document in place and reloads it.
---@param doc? core.docview | core.doc
local function format_doc(doc)
  doc = doc or core.active_view.doc
  if doc:extends(DocView) then doc = doc.doc end
  if not doc or not doc.abs_filename then
    core.error("no doc is open")
    return
  end

  local formatter = get_formatter(doc.filename)
  if formatter == nil then
    core.error("no formatter found for " .. doc.filename)
    return
  end

  local filename = doc.abs_filename

  local args = formatter.args
  local executable = formatter.command[1]

  if config.plugins.formatter[formatter.name] then
    if
      config.plugins.formatter[formatter.name].args
      and
      config.plugins.formatter[formatter.name].args:gsub("%s", "") ~= ""
    then
      args = config.plugins.formatter[formatter.name].args
    end
    if config.plugins.formatter[formatter.name].path then
      executable = config.plugins.formatter[formatter.name].path
    end
  end

  if not command_exists(executable) then
    core.error(
      "formatter '%s' enabled but not found on your system",
      formatter.label
    )
    return
  end

  local command = table.pack(table.unpack(formatter.command))
  command[1] = executable

  local cmd = {}

  -- replace $FILENAME and $ARGS place holders
  for _, arg in ipairs(command) do
    if arg == "$FILENAME" then
      table.insert(cmd, filename)
    elseif arg == "$ARGS" then
      if args then
        for value in args:gmatch("([%S]+)") do
          table.insert(cmd, value)
        end
      end
    else
      local result = arg:gsub("%$FILENAME", '"'..filename..'"')
      table.insert(cmd, result)
    end
  end

  core.log("formatter command: %s", common.serialize(cmd, {pretty = true}))

  core.log("formatting " .. doc.filename .. " with " .. formatter.name)

  core.add_thread(function()
    local p, errmsg = process.start(cmd)
    if not p then
      core.error("could not execute formatter '%s'\n%s", formatter.name, errmsg)
      return
    end
    while not p:wait(0) do
      coroutine.yield()
    end
    reload_doc(doc)
  end)
end

local Doc_save = Doc.save
Doc.save = function(self, ...)
  Doc_save(self, ...)
  if self.skip_format then
     self.skip_format = nil
  elseif
    config.plugins.formatter.format_on_save and get_formatter(self.filename)
  then
    format_doc(self)
  end
end

---Formatter plugin public API.
---@class plugins.formatter
local formatter = {}

---Register a new formatter.
---@param f plugins.formatter.formatter
function formatter.add_formatter(f)
  table.insert(formatters, f)
end

---Modify a registered formatter configuration.
---@param name string
---@param options plugins.formatter.formatter
---@return boolean modified
function formatter.config(name, options)
  local f = formatter.get(name)
  if not f then return false end
  for prop, value in pairs(options) do
    f[prop] = value
  end
  return true
end

---Get a formatter by its name.
---@param name string
---@return plugins.formatter.formatter?
function formatter.get(name)
  for _, f in ipairs(formatters) do
    if f.name == name then
      return f
    end
  end
end

---Get the first formatter that matches the given filename and is enabled.
---@param filename string
---@return plugins.formatter.formatter?
function formatter.get_by_filename(filename)
  return get_formatter(filename)
end

command.add("core.docview", {["formatter:format-doc"] = format_doc})

keymap.add {["alt+shift+f"] = "formatter:format-doc"}


return formatter
