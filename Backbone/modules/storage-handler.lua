---@class Backbone
local context = select(2, ...)

--[[~ Storage handler (module) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local storage = new 'Dictionary'

---
--- ?
---
---@param plugin Plugin
---
local getPluginStorage = function(plugin)
  if not storage:hasEntry(plugin:getIdentifier()) then
    local message =
      'Storage variables are not available until the plugin has been fully loaded (%s)'

    new('Error', message, plugin:getIdentifier())
  end

  return storage:getEntry(plugin) --[[@as Dictionary]]
end

---
--- ?
---
---@param plugin Plugin
---@param scope 'account'|'character'
---@param key string
---
---@return unknown
---
local getStorageVariable = function(plugin, scope, key)
  local plugin_storage = getPluginStorage(plugin)
  return (plugin_storage:getEntry(scope) --[[@as Dictionary]]):getEntry(key)
end

---
--- ?
---
---@param plugin Plugin
---@param scope 'account'|'character'
---@param key string
---@param value unknown
---
local setStorageVariable = function(plugin, scope, key, value)
  local plugin_storage = getPluginStorage(plugin);
  (plugin_storage:getEntry(scope) --[[@as Dictionary]]):setEntry(key, value)
end

---
--- ?
---
---@class Plugin
---
local storage_api = {}

---
--- ?
---
---@param key string
---
storage_api.getAccountVariable = function(self, key)
  return getStorageVariable(self, 'account', key)
end

---
--- ?
---
---@param key string
---@param value unknown
---
storage_api.setAccountVariable = function(self, key, value)
  setStorageVariable(self, 'account', key, value)
end

---
--- ?
---
---@param key string
---
storage_api.getCharacterVariable = function(self, key)
  return getStorageVariable(self, 'character', key)
end

---
--- ?
---
---@param key string
---@param value unknown
---
storage_api.setCharacterVariable = function(self, key, value)
  setStorageVariable(self, 'character', key, value)
end

---
--- ?
---
context.registerPluginExtension(
  function(plugin)
    plugin.getAccountVariable = storage_api.getAccountVariable
    plugin.getCharacterVariable = storage_api.getCharacterVariable
    plugin.setAccountVariable = storage_api.setAccountVariable
    plugin.setCharacterVariable = storage_api.setCharacterVariable

    plugin:onLoad(
      function()
        local plugin_storage = new 'Dictionary'

        for _, scope in ipairs { 'account', 'character' } do
          local variable =
            string.format('%s_storage_%s', plugin:getIdentifier(), scope)

          _G[variable] = (type(_G[variable]) == 'table' and _G[variable]) or {}
          plugin_storage:setEntry(scope, new('Dictionary', _G[variable]))
        end

        storage:setEntry(plugin:getIdentifier(), plugin_storage)
      end --
    )
  end --
)
