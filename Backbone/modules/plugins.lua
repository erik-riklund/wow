---@type string, Repository
local addon, repository = ...

--[[~ Module: Plugins ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---@type hashmap<string, Plugin>
local plugins = {}

---
--- ?
---
---@param name string
---@return Plugin
---
backbone.createPlugin = function(name)
  local identifier = string.lower(name)

  if plugins[identifier] ~= nil then
    backbone.throwError('Failed to register plugin "%s" (non-unique name).', name) --
  end

  plugins[identifier] = { identifier = identifier, name = name }
  repository.invokeChannelListeners('PLUGIN_ADDED', { plugins[identifier] })

  return plugins[identifier]
end
