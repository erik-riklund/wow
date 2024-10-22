--[[~ Module: Plugins ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local _, context = ...

---@type table<string, Plugin>
local plugins = {}

---
--- ?
---
backbone.createChannel(
  context.plugin,
  'PLUGIN_ADDED', --
  { isInternal = true, invokeAsync = false }
)

---
--- ?
---
---@param name string
---@param options any
---
---@return Plugin
---
backbone.createPlugin = function(name, options)
  local identifier = string.lower(name)

  if plugins[identifier] ~= nil then
    backbone.throwException('The plugin "%s" already exists.', name) --
  end

  plugins[identifier] = { identifier = identifier, name = name }
  backbone.invokeChannelListeners(context.plugin, 'PLUGIN_ADDED', { plugins[identifier], options })

  return backbone.utilities.createProtectedProxy(plugins[identifier])
end
