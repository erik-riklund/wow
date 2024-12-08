---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/08 | Author(s): Gopher ]]

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

local prefix = '__settings/'
local settings = new 'Dictionary'

---@param plugin Plugin
---@param key string
---
local getDefaultSetting = function (plugin, key)
  if not settings:hasEntry (plugin) then
    backbone.throw ('The plugin "%s" has not registered default settings.', plugin:getName())
  end

  local keys = split (key, '/'): toArray()
  local value = traverseTable (settings:getEntry (plugin), keys)

  if value == nil then
    backbone.throw ('The setting "%s" is not registered for plugin "%s".', key, plugin:getName())
  end

  return value
end

---@param plugin Plugin
---@param defaults table
---
local registerDefaultSettings = function (plugin, defaults)
  if settings:hasEntry (plugin) then
    backbone.throw ('The plugin "%s" has already registered default settings.', plugin:getName())
  end

  settings:setEntry (plugin, defaults)
end

---@param plugin Plugin
---@param key string
---
local getSetting = function (plugin, key)
  if not settings:hasEntry (plugin) then
    backbone.throw ('The plugin "%s" has not registered default settings.', plugin:getName())
  end

  local defaultValue = getDefaultSetting (plugin, key)
  local keys = split (prefix .. key, '/'): toArray()
  local value = traverseTable (settings:getEntry (plugin), keys)

  return when (value == nil, defaultValue, value)
end

---@param plugin Plugin
---@param key string
---@param value unknown
---
local setSetting = function (plugin, key, value)
  if not settings:hasEntry (plugin) then
    backbone.throw ('The plugin "%s" has not registered default settings.', plugin:getName())
  end

  local defaultValue = getDefaultSetting (plugin, key)
  local parents = split (prefix .. key, '/'): toArray()
  local variable = parents:removeElement() --[[@as string]]

  if type (defaultValue) ~= type (value) then
    backbone.throw ('The value of the setting "%s" must be of type "%s".', key, type (defaultValue))
  end

  traverseTable (settings:getEntry (plugin), parents, 'build')[variable] = value
end

-- PLUGIN API --

---@class Plugin
local settingsAPI = context.pluginAPI

---@param defaults table
---Registers the provided default settings for the plugin.
---
settingsAPI.registerDefaultSettings = function (self, defaults)
  registerDefaultSettings (self, defaults)
end

---@param key string
---@return unknown
---Returns the value of the setting associated with the specified key.
---* The key can be a single key for a flat table, or a slash-separated path of keys for nested tables.
---
settingsAPI.getSetting = function (self, key)
  return getSetting (self, key)
end

---@param key string
---@param value unknown
---Sets the value of the setting associated with the specified key.
---* The key can be a single key for a flat table, or a slash-separated path of keys for nested tables.
---
settingsAPI.setSetting = function (self, key, value)
  setSetting (self, key, value)
end
