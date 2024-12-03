---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/02 | Author(s): Gopher ]]

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
local getVariable = function (plugin, scope, key)
  
end

---@param plugin Plugin
---@param scope 'account'|'character'
---@param key string
---@param value unknown
local setVariable = function (plugin, scope, key, value)
  
end

--- PLUGIN API ---

---@class Plugin
local storageApi = context.pluginApi

---@param key string
---?
storageApi.getAccountVariable = function (self, key)
  return getVariable (self, 'account', key)
end

---@param key string
---@param value unknown
---?
storageApi.setAccountVariable = function (self, key, value)
  setVariable (self, 'account', key, value)
end

---@param key string
---?
storageApi.getCharacterVariable = function (self, key)
  getVariable (self, 'character', key)
end

---@param key string
---@param value unknown
---?
storageApi.setCharacterVariable = function (self, key, value)
  setVariable (self, 'character', key, value)
end

--- PLUGIN STORAGE INITIALIZATION ---

context.plugin:registerChannelListener(
  'PLUGIN_LOADED', {
    ---@param plugin Plugin
    callback = function (plugin)
      -- TODO: implement loading of saved variables.
      context.plugin:invokeChannelListeners('PLUGIN_READY', plugin:getName())
    end
  }
)
