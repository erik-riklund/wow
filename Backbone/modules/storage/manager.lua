---@class Backbone
local context = select(2, ...)

--[[~ Module: Storage ~
  Updated: 2024/10/24 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, table<'account'|'character', StorageUnit>>
local storage = {}

---
--- Retrieves the storage unit for the specified plugin and scope.
---
---@param plugin Plugin
---@param scope 'account'|'character'
---
context.getStorageUnit = function(plugin, scope)
  if not storage[plugin.identifier] or storage[plugin.identifier][scope] == nil  then
    local exception = 'The %s storage unit is not initialized for plugin %s'
    backbone.throwException(exception, scope, plugin.name)
  end

  return storage[plugin.identifier][scope]
end

---
--- Initializes the storage unit for the specified plugin and scope.
---
---@param plugin Plugin
---@param scope 'account'|'character'
---
context.setupStorageUnit = function(plugin, scope)
  storage[plugin.identifier] = storage[plugin.identifier] or {}

  if storage[plugin.identifier][scope] ~= nil then
    local exception = 'A storage unit (%s) already exists for plugin %s'
    backbone.throwException(exception, scope, plugin.name)
  end

  local variable = string.format(
    '%s%sStorage',
    plugin.name,
    backbone.utilities.capitalizeString(scope)
  )

  _G[variable] = _G[variable] or {} -- initialize the saved variable if it's
  --                                   the first time the plugin is loaded.

  storage[plugin.identifier][scope] =
    backbone.components.createStorageUnit(_G[variable])
end
