---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/09 | Author(s): Gopher ]]

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

---A `Vector` object storing registered loading handlers.
context.addonLoaders = new 'Vector'

---@param handler fun(addon_index: number) A function accepting the addon index as a parameter.
---Registers a handler function responsible for a specific loading trigger.
context.registerAddonLoader = function (handler)
  context.addonLoaders:insertElement (handler)
end

---@param addon uiAddon The addon to be loaded.
---Loads the specified addon using the game's addon management system.
context.loadAddon = function (addon) C_AddOns.LoadAddOn (addon) end
