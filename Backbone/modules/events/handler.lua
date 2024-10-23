--[[~ Module: Events ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Event>
local events = {}
local sharedFrame = backbone.getSharedFrame()

---
--- Registers a listener for the specified event.
---
---@param reciever Plugin
---@param eventName string
---@param listener Listener
---
backbone.registerEventListener = function(reciever, eventName, listener)
  if events[eventName] == nil then
    if eventName ~= 'ADDON_LOADED' then
      sharedFrame:RegisterEvent(eventName) --
    else
      listener.persistent = false
      eventName = 'ADDON_LOADED:' .. reciever.identifier
    end

    if events[eventName] == nil then
      -- a second nil check is required to avoid overwriting
      -- existing `ADDON_LOADED` listeners for the reciever.

      events[eventName] = backbone.components.createListenable() --[[@as Event]]
    end
  end

  events[eventName]:registerListener(listener)
end

---
--- Removes the listener with the provided identifier from the specified event.
---
---@param owner Plugin
---@param eventName string
---@param identifier string
---
backbone.removeEventListener = function(owner, eventName, identifier)
  if events[eventName] == nil then
    local exception = 'The event "%s" does not have any registered listeners.'
    backbone.throwException(exception, eventName)
  end

  events[eventName]:removeListener(owner.identifier .. ':' .. identifier)
end

---
--- Registers the "ADDON_LOADED" event, allowing plugins
--- to respond when specific addons are loaded.
---
sharedFrame:RegisterEvent 'ADDON_LOADED'

---
--- Handles all registered events, invoking the associated listeners when an event occurs.
--- Special handling is applied to "ADDON_LOADED" to remove the event after it triggers.
---
sharedFrame:HookScript(
  'OnEvent',
  ---@param eventName string
  function(_, eventName, ...)
    if eventName == 'ADDON_LOADED' then
      local arguments = { ... }
      local addon = string.lower(table.remove(arguments, 1))
      local addonLoadedEvent = 'ADDON_LOADED:' .. addon

      if events[addonLoadedEvent] ~= nil then
        events[addonLoadedEvent]:invokeListeners { arguments = arguments }
        events[eventName] = nil -- allows the event object to be garbage collected.
      end
    else
      if events[eventName] ~= nil then
        if #events[eventName].listeners > 0 then
          events[eventName]:invokeListeners { arguments = { ... } }
        else
          sharedFrame:UnregisterEvent(eventName)
          events[eventName] = nil -- allows the event object to be garbage collected.
        end
      end
    end
  end
)
