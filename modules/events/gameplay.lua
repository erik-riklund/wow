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

---@param eventName string
---@param listener Listener
---
local registerListener = function (eventName, listener)
  if not events:getEntry (eventName) then
    events:setEntry (eventName, new 'Listenable')
    context.frame:RegisterEvent (eventName)
  end

  events:getEntry (eventName) --[[@as Listenable]]:registerListener (listener)
end

---@param eventName string
---@param listenerId string
---
local removeListener = function (eventName, listenerId)
  ---@type Listenable
  local listeners = events:getEntry (eventName)
  if listeners then listeners:removeListener (listenerId) end
end

-- EVENT HANDLER --

context.frame:HookScript(
  'OnEvent', function (frame, eventName, ...)
    ---@cast eventName string
    
    if eventName ~= 'ADDON_LOADED' then
      local event = events:getEntry (eventName) --[[@as Listenable]]

      if event then
        event:invokeListeners (Vector {...})
        
        if event:getListenerCount() == 0 then
          events:dropEntry (eventName)
          context.frame:UnregisterEvent (eventName)
        end
      end
    end
  end
)

--- PLUGIN API ---

---@class Plugin
local eventsAPI = context.pluginApi

---@param eventName string
---@param listener Listener
---Registers a callback function to be executed when the specified event is fired.
---* A unique identifier will be automatically assigned to the listener if one is not provided.
---
eventsAPI.registerEventListener = function (self, eventName, listener)
  listener.id = string.format (
    '%s/%s', self.name, listener.id or string.format ('%s/%s', eventName, GetTimePreciseSec())
  )
  registerListener (eventName, listener)
end

---@param eventName string
---@param listenerId string
---Removes a previously registered event listener.
---
eventsAPI.removeEventListener = function (self, eventName, listenerId)
  removeListener (eventName, string.format ('%s/%s', self.name, listenerId))
end
