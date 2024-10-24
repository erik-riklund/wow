---@class Backbone
local context = select(2, ...)

--[[~ Module: Plugins ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Plugin>
local plugins = {}

---
--- Create the network channel used to broadcast when plugins are added.

local channelOptions = { isInternal = true, invokeAsync = false }
backbone.createChannel(context.plugin, 'PLUGIN_ADDED', channelOptions)

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
    backbone.throwException('The plugin "%s" already exists.', name)
  end

  plugins[identifier] = { identifier = identifier, name = name }

  local arguments = { plugins[identifier], options }
  backbone.invokeChannelListeners(context.plugin, 'PLUGIN_ADDED', arguments)

  return backbone.utilities.createProtectedProxy(plugins[identifier])
end
