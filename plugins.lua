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

local plugins = new 'Dictionary'
local prototype = { __index = context.pluginApi }

---@param name string
---@return Plugin
---Creates a new plugin within the Backbone framework.
backbone.createPlugin = function (name)
  local id = string.lower (name)

  if plugins:hasEntry (id) then
    backbone.throw ('The plugin "%s" already exists.', name)
  end

  ---@class Plugin
  ---@field protected id string
  ---@field protected name string
  local plugin = { id = id, name = name }
  plugins:setEntry (id, setmetatable (plugin, prototype))

  return plugin
end

---@param name string
---Checks whether a plugin with the specified name exists.
---
backbone.hasPlugin = function (name)
  return plugins:hasEntry (string.lower (name))
end

-- INTERNAL PLUGIN --

context.plugin = backbone.createPlugin 'Backbone'
