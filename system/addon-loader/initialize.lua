---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/05 | Author(s): Gopher ]]

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

---@param index number
---@param key string
---@return Vector? metadata
---Retrieves metadata for a specific addon and splits it into a `Vector` if applicable.
---
context.getAddonMetadata = function (index, key)
  local metadata = C_AddOns.GetAddOnMetadata (index, key)
  return (metadata and split(metadata, ',')) or nil
end

---A callback triggered when the plugin loads, registering load-on-demand addons.
context.plugin:onReady(
  function ()
    local addon_count = C_AddOns.GetNumAddOns()
    print 'Hello world!'

    for index = 1, addon_count do
      if C_AddOns.IsAddOnLoadOnDemand (index) then
        DevTools_Dump { C_AddOns.GetAddonInfo(index) }
        --context.handlers:forEach(function (_, handler) handler(index) end)
      end
    end
  end
)
