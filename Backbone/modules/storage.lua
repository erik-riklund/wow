---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

---@type storage.unitConstructor
local createStorageUnit = repository.use 'storage-unit'

--[[~ Module: Storage Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This module manages storage units for both account-wide and character-specific data.
  It allows plugins to easily access and manipulate persistent storage with support 
  for different scopes.

  Features:

  - Create and manage account-wide and character-specific storage units.
  - Access and modify storage variables using provided plugin methods.
  - Dynamically initialize storage variables if not already present.

  Dependencies: storage-unit (component)

]]

---@type table<string, { account?: storage.unit, character?: storage.unit }>
local storage = {}

---
--- Retrieves the storage unit for the specified scope (account or character) for 
--- a given plugin context. Throws an error if the storage unit is not initialized.
---
---@param context plugin "The plugin context requesting the storage unit."
---@param scope   storage.scope "The scope of the storage (either 'account' or 'character')."
---@return storage.unit "The storage unit for the specified scope."
---
local getStorageUnit = function(context, scope)
  if not storage[context.identifier] then
    throw('Storage unit for context "%s" is not initialized.', context.identifier)
  end
  if not storage[context.identifier][scope] then
    throw('Storage unit for scope "%s" is not initialized.', scope)
  end

  return storage[context.identifier][scope]
end

---
--- Sets up the storage unit for the given scope and variable in the specified 
--- plugin context. Initializes the storage variable if it doesn't exist.
---
---@param context  plugin "The plugin context where the storage unit is being set up."
---@param scope    storage.scope "The scope of the storage (either 'account' or 'character')."
---@param variable string "The global variable to back the storage unit."
---
local setupStorageUnit = function(context, scope, variable)
  if not storage[context.identifier] then
    storage[context.identifier] = {}
  end

  if storage[context.identifier][scope] then
    throw('Storage unit for scope "%s" already exists in context "%s".', scope, context.identifier)
  end

  if type(_G[variable]) ~= 'table' then
    _G[variable] = {} -- initialize the specified storage variable.
  end

  storage[context.identifier][scope] = createStorageUnit(variable)
end

-- methods for the framework API:

api.useStorage = function(context, variables)
  xtype.validate {
    { 'variables:table', variables },
    { 'variables.account:string?', variables.account },
    { 'variables.character:string?', variables.character },
  }

  context:onInitialize('setupStorageUnit', function()
    for scope, variable in pairs(variables) do
      setupStorageUnit(context, scope, variable)
    end
  end)
end

-- methods for the plugin API:

plugin.getAccountVariable = function(self, identifier)
  return getStorageUnit(self, 'account'):getEntry(identifier)
end

plugin.setAccountVariable = function(self, identifier, value)
  getStorageUnit(self, 'account'):setEntry(identifier, value)
end

plugin.getCharacterVariable = function(self, identifier)
  return getStorageUnit(self, 'character'):getEntry(identifier)
end

plugin.setCharacterVariable = function(self, identifier, value)
  getStorageUnit(self, 'character'):setEntry(identifier, value)
end
