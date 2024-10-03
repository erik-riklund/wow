local addon, repository = ...

--[[~ Module: Plugins ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

  Features:

  - ?

]]

---@type hashmap<string, Plugin>
local plugins = {}

---
--- ?
---
local api = { __index = repository.pluginApi }

---
--- ?
---
---@param name string
---@return Plugin
---
backbone.createPlugin = function(name)
  -- [explain this section]

  local identifier = string.lower(name)
  if plugins[identifier] ~= nil or identifier == 'backbone' then
    throw('Plugin registration failed for "%s" (non-unique name)', name)
  end

  -- [explain this section]

  plugins[identifier] = setmetatable({ id = identifier, name = name }, api)
  return plugins[identifier]
end

---
---
---
backbone.isPluginRegistered = function(name)
  return (plugins[string.lower(name)] ~= nil)
end
