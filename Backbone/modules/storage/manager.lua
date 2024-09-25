---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

--[[~ Module: ? ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  ?

  Dependencies: ?

]]

---@type table<string, { account?: storage.unit, character?: storage.unit }>
local storage = {}

---
--- ?
---
---@param context plugin "..."
---@param scope   storage.scope "..."
---@return storage.unit "..."
---
local getStorageUnit = function(context, scope)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
---@param context   plugin "..."
---@param scope     storage.scope "..."
---@param variable  string "..."
---
local setupStorageUnit = function(context, scope, variable) end

---
--- ?
---
api.useStorage = function(context, variables)
  xtype.validate { { 'variables:table', variables } }

  context:onInitialize('INIT_STORAGE', function()
    -- ?
    
    for scope, variable in pairs(variables) do
      setupStorageUnit(context, scope, variable)
    end
  end)
end

---
--- ?
---
plugin.getAccountVariable = function(self, identifier)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
plugin.setAccountVariable = function(self, identifier, value) end

---
--- ?
---
plugin.getCharacterVariable = function(self, identifier)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
plugin.setCharacterVariable = function(self, identifier, value) end
