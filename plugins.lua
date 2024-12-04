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

local plugins = new 'Dictionary'
local prototype = { __index = context.pluginApi }

---@param name string
---Creates a new plugin with the specified name.
---* Throws an error if a plugin with that name already exists.
backbone.createPlugin = function (name)
  local id = string.lower (name)
  if plugins:hasEntry (id) then
    backbone.throw ('Unable to register plugin "%s". A plugin with that name already exists.', name)
  end

  ---@class Plugin
  ---@field protected id string
  ---@field protected name string
  local plugin = { id = id, name = name }
  plugins:setEntry (id, setmetatable (plugin, prototype))
  
  EventUtil.ContinueOnAddOnLoaded (plugin:getName(), function ()
    context.plugin:invokeChannelListeners ('PLUGIN_LOADED', plugin)
  end)

  return plugin
end

---@param name string
---Checks if a plugin with the specified name exists.
backbone.hasPlugin = function (name) return plugins:hasEntry (string.lower (name)) end

---Create the plugin used internally by the framework.
context.plugin = backbone.createPlugin 'Backbone'
