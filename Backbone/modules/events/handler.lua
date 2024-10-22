--[[~ Module: Events ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Event>
local events = {}
local sharedFrame = backbone.getSharedFrame()

---
--- ?
---
local createEventObject = function()
  return backbone.components.createListenable() --[[@as Event]]
end

---
--- ?
---
local deleteEventObject = function(eventName) end

---
--- ?
---
---@param reciever Plugin
---@param eventName string
---@param listener Listener
---
backbone.registerEventListener = function(reciever, eventName, listener) end

---
--- ?
---
---@param owner Plugin
---@param eventName string
---@param identifier string
---
backbone.removeEventListener = function(owner, eventName, identifier)
  if events[eventName] == nil then
    backbone.throwException('The event "%s" does not have any registered listeners.', eventName)
  end

  events[eventName]:removeListener(owner.identifier .. ':' .. identifier)
end

---
--- ?
---
sharedFrame:RegisterEvent 'ADDON_LOADED'

---
--- ?
---
sharedFrame:HookScript(
  'OnEvent',
  ---@param eventName string
  function(_, eventName, ...)
    --
  end
)
