---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/04 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

local storage = {
  account = new 'Dictionary',
  character = new 'Dictionary'
}

---@param plugin Plugin
---@param scope 'account'|'character'
---@param key string
---@return unknown
local getVariable = function (plugin, scope, key)
  if not storage[scope]:hasEntry (plugin) then
    backbone.throw ('Plugin "%s" is not fully loaded.', plugin:getName())
  end

  return traverseTable (storage[scope]:getEntry (plugin), split (key, '/'):toArray())
end

---@param plugin Plugin
---@param scope 'account'|'character'
---@param key string
---@param value unknown
local setVariable = function (plugin, scope, key, value)
  if not storage[scope]:hasEntry (plugin) then
    backbone.throw ('Plugin "%s" is not fully loaded.', plugin:getName())
  end

  local parents = split (key, '/')
  local variable = parents:removeElement() --[[@as string]]
  local data = storage[scope]:getEntry (plugin) --[[@as table]]
  local parent = traverseTable (data, parents:toArray(), 'build')

  parent[variable] = value -- sets the value in the saved variables table by reference.
end

--- PLUGIN API ---

---@class Plugin
local storageApi = context.pluginApi

---@param key string
---Gets a saved variable from the plugin's account-wide storage.
---* `key` should be a path to the variable, each step separated by `/`.
---* Returns `nil` if the variable does not exist.
storageApi.getAccountVariable = function (self, key)
  return getVariable (self, 'account', key)
end

---@param key string
---@param value unknown
---Sets a saved variable in the plugin's account-wide storage.
---* `key` should be a path to the variable, each step separated by `/`.
---* Overwrites existing variables.
storageApi.setAccountVariable = function (self, key, value)
  setVariable (self, 'account', key, value)
end

---@param key string
---Gets a saved variable from the plugin's character-specific storage.
---* `key` should be a path to the variable, each step separated by `/`.
---* Returns `nil` if the variable does not exist.
storageApi.getCharacterVariable = function (self, key)
  getVariable (self, 'character', key)
end

---@param key string
---@param value unknown
---Sets a saved variable in the plugin's character-specific storage.
---* `key` should be a path to the variable, each step separated by `/`.
---* Overwrites existing variables.
storageApi.setCharacterVariable = function (self, key, value)
  setVariable (self, 'character', key, value)
end

--- PLUGIN STORAGE INITIALIZATION ---

context.plugin:registerChannelListener(
  'PLUGIN_LOADED', {
    ---@param plugin Plugin
    callback = function (plugin)
      for _, scope in ipairs {'Account', 'Character'} do
        local variableName = string.format (
          '%s%sStorage', plugin:getName(), scope
        )
        
        _G[variableName] = _G[variableName] or {}
        storage[string.lower (scope)]:setEntry (plugin, _G[variableName])
      end

      context.plugin:invokeChannelListeners('PLUGIN_READY', plugin:getName())
    end
  }
)
