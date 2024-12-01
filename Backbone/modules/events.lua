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

local loadEvents = new 'Dictionary'
local activeEvents = new 'Dictionary'

---@param eventName string
---@param listener Listener
---?
local registerListener = function (eventName, listener)
  
end

---@param eventName string
---@param identifier string
---?
local removeListener = function (eventName, identifier)
  
end

---@param addon string
---@param callback function
---?
backbone.onAddonLoaded = function (addon, callback)
  if not loadEvents:hasEntry (addon) then
    loadEvents:setEntry (addon, new 'Listenable')
  end

  (loadEvents:getEntry (addon) --[[@as Listenable]]):
    registerListener({ callback = callback, persistent = false })

    DevTools_Dump (loadEvents)
end

---?
context.frame:RegisterEvent 'ADDON_LOADED'
context.frame:HookScript(
  'OnEvent', function (_, eventName, ...)
    local arguments = Vector { ... }

    if eventName == 'ADDON_LOADED' then
      local addon = arguments:removeElement(1)

      if loadEvents:hasEntry (addon) then
        (loadEvents:getEntry (addon) --[[@as Listenable]]):invokeListeners (arguments)
        loadEvents:dropEntry (addon)
      end
    else
      -- TODO: implement event handling.
    end
  end
)

---@class Plugin
local eventsApi = context.pluginApi


