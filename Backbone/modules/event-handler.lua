---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/19 | Author(s): Gopher ]]

local active_events = new 'Dictionary'

--- Handles events triggered on the frame.
---* Invokes listeners for the triggered event or unregisters events with no listeners.
context.frame:HookScript(
  'OnEvent',

  ---@param event_name string
  ---@param ... unknown
  function (_, event_name, ...)
    local arguments = new ('Vector', { ... })

    if active_events:hasEntry (event_name) then
      local event_handler = active_events:getEntry (event_name) --[[@as Listenable]]
      
      if event_handler:getListenerCount() > 0 then 
        event_handler:invokeListeners (arguments)
      else
        context.frame:UnregisterEvent (event_name)
        active_events:dropEntry (event_name)
      end
    end
  end
)
GetTime()
---@class Plugin
local events_api = {}

---@param callback function
---Registers a one-time callback to be executed when the plugin is loaded.
events_api.onLoad = function (self, callback)
  EventUtil.ContinueOnAddOnLoaded(self.name, callback)
end

---@param event string
---@param listener Listener
--- Registers a listener for a specific event.
---* Automatically registers the event with the frame if it isn't already registered.
events_api.registerEventListener = function (self, event, listener)
  if event == 'ADDON_LOADED' then
    backbone.throw ('Use the native `EventUtil.ContinueOnAddOnLoaded() instead.')
  end

  if not active_events:hasEntry (event) then
    active_events:setEntry (event, new 'Listenable')
    context.frame:RegisterEvent (event)
  end

  if listener.identifier then
    listener.identifier = self.identifier .. '/' .. listener.identifier
  end
  
  (active_events:getEntry (event) --[[@as Listenable]]):registerListener (listener)
end

---@param event string
---@param identifier string
---Removes a registered listener from a specific event.
---* Throws an error if no listeners are registered for the event.
events_api.removeEventListener = function (self, event, identifier)
  if not active_events:hasEntry (event) then
    backbone.throw ('No registered listeners available for the event ' .. event)
  end

  (active_events:getEntry (event) --[[@as Listenable]])
    :removeListener (self.identifier .. '/' .. identifier)
end

---Extends the plugin with event management API methods.
context.registerPluginExtension(
  function (plugin) integrateTable (plugin, events_api) end
)
