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

local events = new 'Dictionary'

-- FRAMEWORK API --

---@param addon string
---@param callback function
---?
---
backbone.onAddonLoaded = function (addon, callback)
  local listenerId = string.format ('%s/%s', addon, GetTimePreciseSec())
  if not events:getEntry (addon) then events:setEntry (addon, new 'Listenable') end

  
end

-- PLUGIN API --

---@class Plugin
local eventsAPI = context.pluginApi

eventsAPI.onReady = function (self, callback) end

-- EVENT HANDLER --

context.frame:SetScript (
  'OnEvent', function (frame, eventName, ...)
    ---@cast eventName string
    
    if eventName == 'ADDON_LOADED' then
      local addonName = select (1, ...)

      if backbone.hasPlugin (addonName) then
        -- TODO: special handling for plugins.
        
        return -- exit early.
      end

      if events:hasEntry (addonName) then
        local listeners = events:getEntry (addonName) --[[@as Listenable]]
        
        listeners:invokeListeners (Vector {...})
        events:dropEntry (addonName)
      end
    end
  end
)
