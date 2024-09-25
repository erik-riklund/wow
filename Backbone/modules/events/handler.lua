---@type string, contextProvider
local addon, repository = ...
local frame = repository.use 'frame' --[[@as Frame]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

---@type listenableConstructor
local createListenableObject = repository.use 'listenable'

--[[~ Module: Event Handler ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  This module manages event listeners within the framework. It provides methods 
  for registering, invoking, and removing event listeners for specific game events. 
  It ensures that listeners are properly tracked, invoked when events occur, 
  and cleaned up when no longer needed.

  Developer's notes:
  
  - The module automatically registers game events and unregisters them when 
    no listeners remain. This prevents unnecessary overhead from unused events.
  
  - Listeners are stored in the `events` table, where each event is associated 
    with its corresponding listeners.
  
  Dependencies: Listenable (for managing listeners)

]]

---@type table<string, event>
local events = {}

---
--- Registers the `ADDON_LOADED` event, as it is essential for initializing
--- many plugins and is one of the core events that this module handles.
---
frame:RegisterEvent 'ADDON_LOADED'

---
--- Registers a listener for a specific event. If the event is not already
--- being tracked, it is registered with the game and added to the internal
--- `events` table for future management.
---
---@param event    string   "The name of the event to listen for."
---@param listener listener "The listener to attach to the event."
---
local registerEventListener = function(event, listener)
  -- Check if the event is already registered in the `events` table. If not,
  -- create a new entry for it, allowing listeners to be attached.

  if events[event] == nil then
    -- Register the event with the game if it's not already being tracked
    -- and is not part of the `ADDON_LOADED` event. This ensures that
    -- only active events are registered, reducing unnecessary overhead.

    if not xstring.hasPrefix(event, 'ADDON_LOADED') then
      frame:RegisterEvent(event)
    end

    -- Create a new listenable object to handle listeners for this event.
    events[event] = createListenableObject() --[[@as event]]
  end

  -- Attach the provided listener to the event, so it will be invoked
  -- whenever the event is triggered by the game.
  events[event]:registerListener(listener)
end

---
--- Removes a listener from a specific event. If no listeners remain after
--- removal, the event is unregistered to free up resources and prevent
--- unnecessary event handling.
---
---@param event      string "The event name from which to remove the listener."
---@param identifier string "The unique identifier for the listener to remove."
---
local removeEventListener = function(event, identifier)
  -- Check if the event has any active listeners. If so, attempt to remove
  -- the listener associated with the given identifier.

  if events[event] ~= nil then
    -- Remove the listener from the event. If it was the last listener,
    -- unregister the event from the game to conserve resources.

    events[event]:removeListener(identifier)

    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then
        frame:UnregisterEvent(event)
      end

      -- Clear the event from the `events` table to free up memory.
      events[event] = nil
    end
    return
  end

  -- Throw an error if the event has no active listeners, as this indicates
  -- an attempt to remove a listener from an unknown or inactive event.
  throw('Event "%s" has no active listeners.', event)
end

---
--- Initializes a plugin by registering a listener for its `ADDON_LOADED` event.
--- This ensures that the plugin's initialization logic is executed when the addon
--- is fully loaded by the game.
---
plugin.onInitialize = function(self, identifier, callback)
  -- Create a listener object that is associated with the plugin's unique
  -- identifier and will trigger the provided callback when the event occurs.

  local listener = {
    identifier = self.identifier .. '.' .. identifier,
    callback = callback,
    persistent = false,
  }

  -- Register the listener for the plugin's `ADDON_LOADED` event, so it is
  -- invoked when the addon is loaded.
  registerEventListener('ADDON_LOADED:' .. self.identifier, listener)
end

---
--- Registers a listener for a specific event, ensuring that the listener's
--- identifier is unique by prepending the plugin's identifier. This allows
--- multiple plugins to register listeners without conflicts.
---
plugin.registerEventListener = function(self, event, listener)
  -- Prepend the plugin's identifier to the listener's identifier to ensure
  -- uniqueness within the framework, preventing collisions between plugins.

  listener.identifier = self.identifier .. '.' .. listener.identifier
  registerEventListener(event, listener)
end

---
--- Removes a listener from a specific event using the plugin's unique
--- identifier to ensure that the correct listener is removed.
---
plugin.removeEventListener = function(self, event, identifier)
  -- Remove the listener associated with the plugin's unique identifier
  -- from the specified event.

  removeEventListener(event, self.identifier .. '.' .. identifier)
end

---
--- The event handler listens for game events and triggers the appropriate
--- listeners when an event occurs. It checks if the event is registered and
--- has active listeners, invoking them if they exist.
---
frame:SetScript('OnEvent', function(source, event, ...)
  -- Handle the special case for the `ADDON_LOADED` event, where the event name
  -- includes the specific addon name. This allows the event handler to work
  -- with addon-specific loading events.

  if event == 'ADDON_LOADED' then event = string.format('ADDON_LOADED:%s', ...) end

  -- Check if there are any listeners registered for the event. If listeners
  -- exist, invoke them with the event arguments.

  if events[event] ~= nil then
    -- Invoke all listeners associated with the event, passing along any
    -- arguments provided by the event.

    events[event]:invokeListeners { source, ... }

    -- If no listeners remain after invocation, unregister the event and
    -- remove it from memory to conserve resources.

    if #events[event].listeners == 0 then
      if not xstring.hasPrefix(event, 'ADDON_LOADED') then
        frame:UnregisterEvent(event)
      end

      events[event] = nil -- Clear the event to free memory.
    end
  end
end)
