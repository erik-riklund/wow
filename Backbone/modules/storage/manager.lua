---@class Backbone
local context = select(2, ...)

--[[~ Module: Storage ~
  Updated: 2024/10/24 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, StorageUnit>
local storage = {}

---
--- Retrieves the storage unit for the specified plugin.
---
---@param plugin Plugin
---
context.getStorageUnit = function(plugin)
  if storage[plugin.identifier] == nil then
    local exception = 'No storage unit initialized for plugin "%s"'
    backbone.throwException(exception, plugin.identifier)
  end

  return storage[plugin.identifier]
end

---
--- Initializes the storage unit for the specified plugin.
---
---@param plugin Plugin
---@param variable string
---
context.setupStorageUnit = function(plugin, variable)
  if storage[plugin.identifier] ~= nil then
    local exception = 'A storage unit already exists for plugin "%s"'
    backbone.throwException(exception, plugin.identifier)
  end

  _G[variable] = _G[variable] or {} -- initializes the saved variable if it's the first time the plugin is loaded.
  storage[plugin.identifier] = backbone.components.createStorageUnit(_G[variable])
end
