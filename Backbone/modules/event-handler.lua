---@class Backbone
local context = select(2, ...)

--[[~ Event handler (module) ~
  Updated: 2024/11/19 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local active_events = new 'Dictionary'

---
--- ?
---
context.frame:RegisterEvent 'ADDON_LOADED'

---
--- ?
---
context.frame:HookScript(
  'OnEvent',
  ---@param event WowEvent
  ---@param ... unknown
  function(_, event, ...)
    local arguments = new('Vector', { ... })
    local event_id = event --[[@as string]]

    if event == 'ADDON_LOADED' then
      event_id = 'ADDON_LOADED/' .. string.lower(arguments:removeElement(1))
    end

    if active_events:hasEntry(event_id) then
      local event_handler = active_events:getEntry(event_id) --[[@as Listenable]]

      if event_handler:getListenerCount() > 0 then
        event_handler:invokeListeners(arguments)
      else
        context.frame:UnregisterEvent(event)
        active_events:dropEntry(event_id)
      end

      if event == 'ADDON_LOADED' then active_events:dropEntry(event_id) end
    end
  end
)

---
---@class Plugin
---
local events_api = {}

---
--- ?
---
---@param callback function
---
events_api.onLoad = function(self, callback)
  local event = 'ADDON_LOADED/' .. self.identifier

  if not active_events:hasEntry(event) then
    active_events:setEntry(event, new 'Listenable')
  end

  local listener = { callback = callback, persistent = false };
  (active_events:getEntry(event) --[[@as Listenable]]):registerListener(listener)
end

---
--- ?
---
---@param event WowEvent
---@param listener Listener
---
events_api.registerEventListener = function(self, event, listener)
  if not active_events:hasEntry(event) then
    active_events:setEntry(event, new 'Listenable')
    context.frame:RegisterEvent(event)
  end

  if listener.identifier then
    listener.identifier = self.identifier .. '/' .. listener.identifier
  end

  (active_events:getEntry(event) --[[@as Listenable]]):registerListener(listener)
end

---
--- ?
---
---@param event WowEvent
---@param identifier string
---
events_api.removeEventListener = function(self, event, identifier)
  if not active_events:hasEntry(event) then
    new('Error', 'No registered listeners available for the event ' .. event)
  end

  (active_events:getEntry(event) --[[@as Listenable]])
    :removeListener(self.identifier .. '/' .. identifier)
end

---
--- ?
---
context.registerPluginExtension(
  function(plugin)
    plugin.onLoad = events_api.onLoad
    
    plugin.registerEventListener = events_api.registerEventListener
    plugin.removeEventListener = events_api.removeEventListener
  end
)
