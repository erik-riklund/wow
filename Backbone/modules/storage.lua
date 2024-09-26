---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

---@type storage.unitConstructor
local createStorageUnit = repository.use 'storage-unit'

--[[~ Module: ? ~
  
  Version: 1.0.0 | Updated: 2024/09/26

  ?

  Features:

  - ?

]]

---@type table<string, { account?: storage.unit, character?: storage.unit }>
local storage = {}

---
--- ?
---
---@param context plugin "..."
---@param scope   storage.scope "..."
---
---@return storage.unit "..."
---
local getStorageUnit = function(context, scope)
  if not storage[context.identifier] then throw '?' end
  if not storage[context.identifier][scope] then throw '?' end

  return storage[context.identifier][scope]
end

---
--- ?
---
---@param context  plugin "..."
---@param scope    storage.scope "..."
---@param variable string "..."
---
local setupStorageUnit = function(context, scope, variable)
  if not storage[context.identifier] then storage[context.identifier] = {} end
  if storage[context.identifier][scope] then throw '?' end
  if type(_G[variable]) ~= 'table' then throw '?' end

  storage[context.identifier][scope] = createStorageUnit(variable)
end

-- methods for the framework API:

api.useStorage = function(context, variables)
  xtype.validate {
    { 'variables:table', variables },
    { 'variables.account:string?', variables.account },
    { 'variables.character:string?', variables.character },
  }

  context:onInitialize('INIT_STORAGE', function()
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
