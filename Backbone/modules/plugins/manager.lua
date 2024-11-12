---@class Backbone
local context = select(2, ...)

--[[~ Plugins ~
  Updated: 2024/10/29 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Plugin>
local plugins = {}

---
--- Creates a new plugin with the specified name and optional configuration options.
---
---@param name string
---@param options? PluginOptions
---
---@return Plugin
---
backbone.createPlugin = function(name, options)
  local identifier = string.lower(name)
  if plugins[identifier] ~= nil then
    backbone.throwException('The plugin "%s" already exists.', name) --
  end

  plugins[identifier] = { identifier = identifier, name = name }
  
  for _, callback in ipairs(context.apis) do
    callback(plugins[identifier], options)
  end

  return plugins[identifier]
end

---
--- Checks if a plugin with the specified name is registered within the system.
---
---@param name string
---
backbone.hasPlugin = function(name)
  return (plugins[string.lower(name)] ~= nil) --
end
