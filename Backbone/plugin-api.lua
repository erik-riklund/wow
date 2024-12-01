---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/01 | Author(s): Gopher ]]

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

---@class Plugin
context.pluginApi = {}

--- Retrieves the unique identifier of the plugin.
--- @return string id The unique ID of the plugin.
context.pluginApi.getId = function (self) return self.id end

--- Retrieves the display name of the plugin.
--- @return string name The name of the plugin.
context.pluginApi.getName = function (self) return self.name end
