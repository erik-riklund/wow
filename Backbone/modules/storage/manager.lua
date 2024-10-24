---@class Backbone
local context = select(2, ...)

--[[~ Module: Storage ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, StorageUnits>
local storageUnits = {}

---
--- Retrieves a storage unit for a given plugin and specified scope.
---
---@param plugin Plugin
---@param scope StorageScope
---
---@return StorageUnit
---
context.getStorageUnit = function(plugin, scope)
  if storageUnits[plugin.identifier] == nil then
    backbone.throwException('No storage units available (%s).', plugin.name)
  end

  if storageUnits[plugin.identifier][scope] == nil then
    local exception = 'The %s storage unit has not been initialized (%s).'
    backbone.throwException(exception, scope, plugin.name)
  end

  return storageUnits[plugin.identifier][scope]
end

---
--- Initializes a storage unit for a plugin with a specified scope and source data.
---
---@param plugin Plugin
---@param scope StorageScope
---@param variable string
---
context.setupStorageUnit = function(plugin, scope, variable)
  _G[variable] = _G[variable] or {}

  if type(_G[variable]) ~= 'table' then
    local exception = 'Failed to initialize storage, `_G.%s` is not a table (%s).'
    backbone.throwException(exception, variable, plugin.name)
  end

  storageUnits[plugin.identifier] = storageUnits[plugin.identifier] or {}
  storageUnits[plugin.identifier][scope] =
    backbone.components.createStorageUnit(_G[variable])
end
