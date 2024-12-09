---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/05 | Author(s): Gopher ]]

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

---@class Backbone.Plugin
context.pluginAPI = {}

---Returns the identifier of the plugin.
---
context.pluginAPI.getId = function (self) return self.id end

---Returns the name of the plugin.
---
context.pluginAPI.getName = function (self) return self.name end

---Stores all registered plugins, indexed by their identifiers.
---
context.plugins = new 'Dictionary'

---@param name string
---@return Backbone.Plugin
---Creates a new plugin with the specified name.
---* If a plugin with the specified name already exists, an error is raised.
---
backbone.createPlugin = function (name)
  local pluginId = string.lower (name)
  if context.plugins:hasEntry (pluginId) then
    backbone.throw ('The plugin "%s" already exists.', name)
  end

  ---@class Backbone.Plugin
  ---@field protected id string
  ---@field protected name string
  local plugin = { id = pluginId, name = name }

  context.plugins:setEntry (pluginId,
    setmetatable (plugin, { __index = context.pluginAPI })
  )

  return plugin
end

---@param name string
---Checks whether the specified plugin is loaded.
---* Returns `true` if the plugin is loaded, `false` otherwise.
---
backbone.hasPlugin = function (name)
  return context.plugins:hasEntry (string.lower (name)) and backbone.isAddonLoaded (name)
end

-- INTERNAL PLUGIN --

context.plugin = backbone.createPlugin 'Backbone'
