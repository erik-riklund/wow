---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/20 | Author(s): Gopher ]]

local storage = new 'Dictionary'

---@param plugin Plugin The plugin for which to retrieve storage.
---@return Dictionary storage_unit The storage unit for the plugin.
---Retrieves the storage dictionary for a given plugin.
---* Throws an error if the plugin storage is not initialized.
local getPluginStorage = function (plugin)
  if not storage:hasEntry (plugin:getIdentifier()) then
    new ('Error', 'Storage variables are not available until the plugin '
      .. 'has been fully loaded (%s)', plugin:getIdentifier())
  end
  return storage:getEntry (plugin:getIdentifier()) --[[@as Dictionary]]
end

---@param plugin Plugin The plugin for which to retrieve the variable.
---@param scope 'account'|'character' The storage scope (account or character).
---@param key string The key of the variable to retrieve.
---@return unknown value The value of the variable.
---Retrieves a variable from the plugin's storage by scope and key.
local getStorageVariable = function (plugin, scope, key)
  local plugin_storage = getPluginStorage (plugin)
  return (plugin_storage:getEntry (scope) --[[@as Dictionary]]):getEntry (key)
end

---@param plugin Plugin The plugin for which to set the variable.
---@param scope 'account'|'character' The storage scope (account or character).
---@param key string The key of the variable to set.
---@param value unknown The value to assign to the variable.
---Sets a variable in the plugin's storage by scope and key.
local setStorageVariable = function (plugin, scope, key, value)
  local plugin_storage = getPluginStorage (plugin);
  (plugin_storage:getEntry (scope) --[[@as Dictionary]]):setEntry (key, value)
end

---@class Plugin
local storage_api = {}

---@param key string The key of the variable to retrieve.
---@return unknown value The value of the variable.
---Retrieves an account-wide storage variable for the plugin.
storage_api.getAccountVariable = function (self, key) return getStorageVariable (self, 'account', key) end

---@param key string The key of the variable to set.
---@param value unknown The value to assign to the variable.
---Sets an account-wide storage variable for the plugin.
storage_api.setAccountVariable = function (self, key, value) setStorageVariable (self, 'account', key, value) end

---@param key string The key of the variable to retrieve.
---@return unknown value The value of the variable.
---Retrieves a character-specific storage variable for the plugin.
storage_api.getCharacterVariable = function (self, key) return getStorageVariable (self, 'character', key) end

---@param key string The key of the variable to set.
---@param value unknown The value to assign to the variable.
---Sets a character-specific storage variable for the plugin.
storage_api.setCharacterVariable = function (self, key, value) setStorageVariable (self, 'character', key, value) end

---Extends the plugin with storage management functionality.
---* Initializes storage for account and character scopes upon plugin load.
context.registerPluginExtension(
  function (plugin)
    plugin.getAccountVariable = storage_api.getAccountVariable
    plugin.getCharacterVariable = storage_api.getCharacterVariable
    plugin.setAccountVariable = storage_api.setAccountVariable
    plugin.setCharacterVariable = storage_api.setCharacterVariable

    plugin:onLoad(
      function ()
        local plugin_storage = new 'Dictionary'
        for _, scope in ipairs { 'account', 'character' } do
          local variable = string.format ('%s_%s_storage', plugin:getIdentifier(), scope)
          _G[variable] = (type (_G[variable]) == 'table' and _G[variable]) or {}
          plugin_storage:setEntry (scope, new ('Dictionary', _G[variable]))
        end
        storage:setEntry (plugin:getIdentifier(), plugin_storage)
      end
    )
  end
)
