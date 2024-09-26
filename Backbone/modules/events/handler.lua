---@type string, contextProvider
local addon, repository = ...
local frame = repository.use 'frame' --[[@as Frame]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

---@type listenableConstructor
local createListenableObject = repository.use 'listenable'

--[[~ Module: Event Handler ~

  Version: 1.0.0 | Updated: 2024/09/26

  The Event Handler module manages event registration and dispatching within the 
  framework. It allows listeners to be registered for specific events and ensures 
  that they are invoked when the event occurs. The module provides support for 
  automatically removing events when no more listeners are registered.

  Features:

  - Register listeners for specific events.
  - Automatically unregister events when no listeners remain.
  - Handle the special case of `ADDON_LOADED` for plugin initialization.

]]

---@type table<string, event>
local events = {}

frame:RegisterEvent 'ADDON_LOADED'

---
--- Registers a listener for the specified event. If the event is not already registered,
--- it is added to the `events` table and registered with the game.
---
---@param event    string   "The name of the event to register the listener for."
---@param listener listener "The listener to attach to the event."
---
local registerEventListener = function(event, listener)
  if events[event] == nil then
    if not xstring.hasPrefix(event, 'ADDON_LOADED') then
      frame:RegisterEvent(event)
    end

    events[event] = createListenableObject() --[[@as event]]
  end

  events[event]:registerListener(listener)
end

---
--- Removes a listener from the specified event. If no listeners remain, the event
--- is unregistered from the game to conserve resources.
---
---@param event      string "The name of the event to remove the listener from."
---@param identifier string "The unique identifier of the listener to remove."
---
local removeEventListener = function(event, identifier)
  if events[event] ~= nil then
    events[event]:removeListener(identifier)

    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then
        frame:UnregisterEvent(event)
      end

      events[event] = nil
    end
    return
  end

  throw('Event "%s" has no active listeners.', event)
end

plugin.onInitialize = function(self, identifier, callback)
  local listener = {
    identifier = self.identifier .. '.' .. identifier,
    callback = callback,
    persistent = false,
  }

  registerEventListener('ADDON_LOADED:' .. self.identifier, listener)
end

plugin.registerEventListener = function(self, event, listener)
  listener.identifier = self.identifier .. '.' .. listener.identifier
  registerEventListener(event, listener)
end

plugin.removeEventListener = function(self, event, identifier)
  removeEventListener(event, self.identifier .. '.' .. identifier)
end

frame:SetScript('OnEvent', function(source, event, ...)
  if event == 'ADDON_LOADED' then event = string.format('ADDON_LOADED:%s', ...) end

  if events[event] ~= nil then
    events[event]:invokeListeners { source, ... }

    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then
        frame:UnregisterEvent(event)
      end

      events[event] = nil
    end
  end
end)
