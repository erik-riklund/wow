--[[~ Module: Plugins ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local _, context = ...

---@type table<string, Plugin>
local plugins = {}

---
--- ?

local channelOptions = { isInternal = true, invokeAsync = false }
backbone.createChannel(context.plugin, 'PLUGIN_ADDED', channelOptions)

---
--- ?
---
---@param name string
---@param options? PluginOptions
---
---@return Plugin
---
backbone.createPlugin = function(name, options)
  local identifier = string.lower(name)

  if plugins[identifier] ~= nil then
    backbone.throwException('The plugin "%s" already exists.', name)
  end

  plugins[identifier] = { identifier = identifier, name = name }

  local arguments = { plugins[identifier], options }
  backbone.invokeChannelListeners(context.plugin, 'PLUGIN_ADDED', arguments)

  return backbone.utilities.createProtectedProxy(plugins[identifier])
end
