--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|
--
--- @type string, Context
local addon, framework = ...
local exception = _G.exception
local type = _G.type

local beginsWith = framework.import('string/begins') --[[@as InitialSubstring]]
local createListenerManager = framework.import('shared/listeners') --[[@as ListenerManagerConstructor]]
local createRecord = framework.import('collection/record') --[[@as RecordConstructor]]
local mergeTables = framework.import('table/merge') --[[@as TableMerger]]

--
-- Centralizes event handling across the framework, enabling registration,
-- triggering, and management of event listeners.
--
--- @type Frame
--
local frame = CreateFrame('Frame', 'CogspinnerEventHandler')

--
-- Hides the frame, as it's solely for event handling and not visual display.
--
frame:SetShown(false)

--
-- Registers the 'ADDON_LOADED' event for plugin initialization and setup.
--
frame:RegisterEvent('ADDON_LOADED')

--
-- A record for storing registered events and their listener managers,
-- ensuring uniqueness and efficient lookup.
--
local events = createRecord()

--
-- The central event handler manages and dispatches events to their respective listeners.
--
--- @type EventHandler
--
local handler = {
  --
  -- Registers an event listener, creating necessary data structures, with special
  -- handling for 'ADDON_LOADED' to ensure proper plugin initialization.
  --
  registerListener = function(eventName, listener, context)
    -- ~ Input validation and type checking to prevent errors.

    if type(eventName) ~= 'string' then
      exception('Invalid event name. Expected a string.')
    end

    if type(listener) ~= 'table' then
      exception('Invalid listener. Expected a table representing a listener object.')
    end

    if context and type(context) ~= 'string' then
      exception('Invalid context. Expected a string (or nil).')
    end

    -- ~ Register the event with the frame, unless it's already registered.

    if not events:entryExists(eventName) then
      if not beginsWith(eventName, 'ADDON_LOADED') then
        frame:RegisterEvent(eventName)
      end

      events:set(eventName, createListenerManager())
    end

    -- ~ Add the listener to the manager for the corresponding event.

    local newEventListener = mergeTables(listener, { owner = context });
    (events:get(eventName) --[[@as Event]] ):registerListener(newEventListener)
  end,

  --
  -- Removes a listener from an event, potentially unregistering the event if no listeners
  -- remain. Note that 'ADDON_LOADED' events cannot be directly unsubscribed.
  --
  removeListener = function(eventName, identifier, context)
    -- ~ Validate input arguments.

    if type(eventName) ~= 'string' then
      exception('Invalid event name. Expected a string.')
    end

    if eventName == 'ADDON_LOADED' then
      exception('Cannot unsubscribe listeners from the "ADDON_LOADED" event.')
    end

    if type(identifier) ~= 'string' then
      exception('Invalid listener identifier. Expected a string.')
    end

    if context and type(context) ~= 'string' then
      exception('Invalid context. Expected a string (or nil).')
    end

    if not events:entryExists(eventName) then
      exception('Listener removal failed: Event "%s" is not registered.', eventName)
    end

    -- ~ Retrieve the event's listener manager and attempt to remove the listener.

    local event = events:get(eventName) --[[@as Event]]
    local listener = event:retrieveListener(identifier) --[[@as EventListener]]

    if not listener then
      exception('Listener removal failed: Listener with ID "%s" not found for event "%s".', identifier, eventName)
    end

    if listener.owner ~= context then
      exception('Listener removal failed: The listener "%s" does not belong to the calling context (%s).', identifier, context)
    end

    event:removeListener(identifier)

    -- ~ If no listeners remain for the event, unregister it from the frame.

    if event.listeners:size() == 0 then
      frame:UnregisterEvent(eventName)
    end
  end,

  --
  -- Invokes all listeners registered for a specific event, passing the event arguments to each.
  --
  invokeEvent = function(eventName, ...)
    if events:entryExists(eventName) then
      (events:get(eventName) --[[@as Event]] ):invokeListeners({ ... })
    end
  end
}

--
-- The core event handling function, triggered by the WoW API upon the occurrence of a registered event.
-- It processes the event and dispatches it to the appropriate listeners.
--
frame:SetScript('OnEvent', function(self, eventName, ...)
  -- ~ Handles the special case of the 'ADDON_LOADED' event,
  -- ~ which includes the addon name as an additional argument.

  if eventName == 'ADDON_LOADED' then
    local loadedAddonName = ...
    eventName = 'ADDON_LOADED:' .. loadedAddonName
  end

  -- ~ Invoke the event handler to trigger any registered listeners for this event.

  handler.invokeEvent(eventName, ...)
end)

--
-- Expose the event handler to the framework context.
--
framework.export('module/events', handler)
