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

local storage = new 'Dictionary'

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

---?
storageApi.getAccountVariable = function (self, key)
  
end

---?
storageApi.setAccountVariable = function (self, key, value)
  
end

---?
storageApi.getCharacterVariable = function (self, key)
  
end

---?
storageApi.setCharacterVariable = function (self, key, value)
  
end

--- PLUGIN STORAGE INITIALIZATION ---

context.plugin:registerChannelListener(
  'PLUGIN_LOADED', {
    ---@param plugin Plugin
    callback = function (plugin)
      print 'Eh?'
    end
  }
)
