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

local prefix = '__config/'
local settings = new 'Dictionary'

---@param plugin Plugin
---@param key string
local getSetting = function (plugin, key)
  local value = plugin:getAccountVariable (prefix .. key)
  if value == nil then value = plugin:getDefaultSetting (key) end

  return value
end

---@param plugin Plugin
---@param key string
---@param value unknown
local setSetting = function (plugin, key, value)
end

---@param plugin Plugin
---@param key string
local getDefaultSetting = function (plugin, key)
  if not settings:hasEntry (plugin) then
    backbone.throw ('Default settings are not registered (%s).', plugin:getName())
  end
  
  local value = traverseTable (settings:getEntry (plugin), split (key, '/'):toArray())
  if value == nil then backbone.throw ('Setting "%s" does not exist (%s).', key, plugin:getName()) end

  return value
end

--- FRAMEWORK API ---

---@param plugin Plugin
---@param defaults table
---Registers default settings for a plugin.
---* Throws an error if the default settings are already registered for the plugin.
backbone.registerDefaultSettings = function (plugin, defaults)
  if settings:hasEntry (plugin) then
    backbone.throw ('Default settings are already registered (%s).', plugin:getName())
  end
  settings:setEntry (plugin, defaults)
end

--- PLUGIN API ---

---@class Plugin
local settingsApi = context.pluginApi

---@param key string
---@return unknown
---Returns the value of a setting for the plugin.
---* Throws an error if the setting does not exist.
settingsApi.getSetting = function (self, key)
  return getSetting (self, key)
end

---@param key string
---@param value unknown
---Sets the value of a setting for the plugin.
---* Throws an error if the setting is not defined in the default settings
---* Throws an error if the value type does not match the default value type.
settingsApi.setSetting = function (self, key, value)
  setSetting (self, key, value)
end

---@param key string
---@return unknown
---Returns the default value of a setting for the plugin.
---* Throws an error if the setting does not exist.
settingsApi.getDefaultSetting = function (self, key)
  return getDefaultSetting (self, key)
end
