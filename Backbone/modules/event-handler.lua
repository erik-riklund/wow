---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/19 | Author(s): Gopher ]]

local active_events = new 'Dictionary'
context.frame:RegisterEvent 'ADDON_LOADED'

--- Handles events triggered on the frame.
---* Invokes listeners for the triggered event or unregisters events with no listeners.
context.frame:HookScript(
  'OnEvent',

  ---@param event string
  ---@param ... unknown
  function (_, event, ...)
    local arguments = new ('Vector', { ... })
    local event_id = event --[[@as string]]

    if event == 'ADDON_LOADED' then 
      event_id = 'ADDON_LOADED/' .. string.lower (arguments:removeElement (1))
    end

    if active_events:hasEntry (event_id) then
      local event_handler = active_events:getEntry (event_id) --[[@as Listenable]]
      
      if event_handler:getListenerCount () > 0 then 
        event_handler:invokeListeners (arguments)
      else 
        context.frame:UnregisterEvent (event)
        active_events:dropEntry (event_id)
      end

      if event == 'ADDON_LOADED' then active_events:dropEntry (event_id) end
    end
  end
)

---@class Plugin
local events_api = {}

---@param callback function
---Registers a one-time callback to be executed when the plugin is loaded.
events_api.onLoad = function (self, callback)
  local event = 'ADDON_LOADED/' .. self.identifier
  if not active_events:hasEntry (event) then
    active_events:setEntry (event, new 'Listenable')
  end

  local listener = { callback = callback, persistent = false };
  (active_events:getEntry (event) --[[@as Listenable]]):registerListener (listener)
end

---@param event string
---@param listener Listener
--- Registers a listener for a specific event.
---* Automatically registers the event with the frame if it isn't already registered.
events_api.registerEventListener = function (self, event, listener)
  if not active_events:hasEntry (event) then
    active_events:setEntry (event, new 'Listenable')
    context.frame:RegisterEvent (event)
  end

  if listener.identifier then listener.identifier = self.identifier .. '/' .. listener.identifier end
  (active_events:getEntry (event) --[[@as Listenable]]):registerListener (listener)
end

---@param event string
---@param identifier string
---Removes a registered listener from a specific event.
---* Throws an error if no listeners are registered for the event.
events_api.removeEventListener = function (self, event, identifier)
  if not active_events:hasEntry (event) then
    new ('Error', 'No registered listeners available for the event ' .. event)
  end
  (active_events:getEntry (event) --[[@as Listenable]]):removeListener (self.identifier .. '/' .. identifier)
end

---Extends the plugin with event management API methods.
context.registerPluginExtension(
  function (plugin)
    plugin.onLoad = events_api.onLoad
    plugin.registerEventListener = events_api.registerEventListener
    plugin.removeEventListener = events_api.removeEventListener
  end
)
