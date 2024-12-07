---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/07 | Author(s): Gopher ]]

--Backbone - A World of Warcraft addon framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

local storage = new 'Dictionary'

---@param plugin Plugin
---@param scope 'account'|'character'
---@param key string
---@return unknown?
---
local getVariable = function (plugin, scope, key)
  print 'getVariable not implemented'
end

---@param plugin Plugin
---@param scope 'account'|'character'
---@param key string
---@param value unknown
---
local setVariable = function (plugin, scope, key, value)
  print 'setVariable not implemented'
end

-- STORAGE INITIALIZATION --

context.plugin:registerChannelListener (
  'PLUGIN_LOADED', {
    callback = function (plugin)
      ---@cast plugin Plugin
      local pluginData = {}

      for _, scope in ipairs {'Account', 'Character'} do
        local variableName = string.format (
          '%s%sVariables', plugin:getName(), scope
        )

        _G[variableName] = _G[variableName] or {}
        pluginData[string.lower (scope)] = _G[variableName]
      end

      storage:setEntry (plugin, pluginData)
    end
  }
)

-- PLUGIN API --

---@class Plugin
local storageAPI = context.pluginAPI

---@param key string
---@return unknown?
---Returns the value associated with the specified key.
---
storageAPI.getAccountVariable = function (self, key)
  return getVariable (self, 'account', key)
end

---@param key string
---@param value unknown
---Sets the value associated with the specified key.
---
storageAPI.setAccountVariable = function (self, key, value)
  setVariable (self, 'account', key, value)
end

---@param key string
---@return unknown?
---Returns the value associated with the specified key.
---
storageAPI.getCharacterVariable = function (self, key)
  return getVariable (self, 'character', key)
end

---@param key string
---@param value unknown
---Sets the value associated with the specified key.
---
storageAPI.setCharacterVariable = function (self, key, value)
  setVariable (self, 'character', key, value)
end
