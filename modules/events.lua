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

local events = new 'Dictionary'
local loadEvents = new 'Dictionary'

---@param eventName string
---@param listener Listener
local registerListener = function (eventName, listener)
  if eventName == 'ADDON_LOADED' then
    backbone.throw 'Use `backbone.onAddonLoaded` instead.'
  end

  ---@type Listenable?
  local event = events:getEntry (eventName)

  if event == nil then
    event = new 'Listenable'

    context.frame:RegisterEvent (eventName)
    events:setEntry (eventName, event)
  end

  event:registerListener (listener)
end

---@param eventName string
---@param identifier string
local removeListener = function (eventName, identifier)
  if eventName == 'ADDON_LOADED' then
    backbone.throw '`ADDON_LOADED` listeners are removed automatically.'
  end

  ---@type Listenable?
  local event = events:getEntry (eventName)
  if event ~= nil then
    return event:removeListener (identifier) -- remove the listener and cancel execution.
  end

  backbone.throw ('The event "%s" have no active listeners.', eventName)
end

context.frame:RegisterEvent 'ADDON_LOADED'
context.frame:HookScript(
  'OnEvent', function (_, eventName, ...)
    local arguments = Vector { ... }

    if eventName == 'ADDON_LOADED' then
      local addon = arguments:removeElement(1)

      if loadEvents:hasEntry (addon) then
        ---@type Listenable
        local event = loadEvents:getEntry (addon)
        
        event:invokeListeners (arguments)
        loadEvents:dropEntry (addon)
      end

      return -- stop execution.
    end

    if events:hasEntry (eventName) then
      ---@type Listenable
      local event = events:getEntry (eventName)

      -- TODO: invoke listeners.

      if event:getListenerCount() == 0 then
        context.frame:UnregisterEvent (eventName)
        events:dropEntry (eventName)
      end
    end
  end
)

--- FRAMEWORK API ---

---@param addon string
---@param callback function
---Registers a callback to be invoked when the specified addon is fully loaded.
backbone.onAddonLoaded = function (addon, callback)
  if not loadEvents:hasEntry (addon) then
    loadEvents:setEntry (addon, new 'Listenable')
  end

  (loadEvents:getEntry (addon) --[[@as Listenable]]):
    registerListener({ callback = callback, persistent = false })
end

--- PLUGIN API ---

---@class Plugin
local eventsApi = context.pluginApi

---@param callback function
---Registers a function to be executed when the plugin is fully initialized. Can be used
---any number of times; the registered functions are executed in the order they were added.
eventsApi.onReady = function (self, callback)
  local listenerId = tostring (GetTimePreciseSec())

  self:registerChannelListener ('PLUGIN_READY', {
    id = listenerId,

    ---@param pluginName string
    callback = function (pluginName)
      if pluginName == self:getName() then
        callback() -- invoke the provided callback.
        context.plugin:removeChannelListener('PLUGIN_READY', listenerId)
      end
    end
  })
end

---@param event WowEvent
---@param listener Listener
---Registers a listener for a specified game event.
eventsApi.registerEventListener = function (self, event, listener)
  if listener.id then
    listener.id = string.format ('%s/%s', self.name, listener.id)
  end

  registerListener (event, listener)
end

---@param event WowEvent
---@param id string
---Removes a previously registered event listener for a specified event.
eventsApi.removeEventListener = function (self, event, id)
  removeListener (event, string.format ('%s/%s', self.name, id))
end
