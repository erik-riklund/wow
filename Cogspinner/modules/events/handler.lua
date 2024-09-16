--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

-- #region << imports >>
--- @type Frame
local frame = framework.import('core/frame')
--- @type listenerManager.constructor
local createListenerManager = framework.import('shared/listeners')
-- #endregion

---
--- Serves as a central hub for storing and managing
--- event listeners within the framework.
---
--- @type table<string, listenerManager>
---
local events = {}

---
--- Registers a new event, creating a listener manager for it. If the event
--- is not 'ADDON_LOADED', it is also registered using the game API.
---
--- @param name string
---
local registerEvent = function(name)
  events[name] = createListenerManager()

  if not startsWith(name, 'ADDON_LOADED') then
    frame:RegisterEvent(name)
  end
end

---
--- Unregisters an event, removing its listener manager. If the event is not
--- 'ADDON_LOADED', it is also unregistered using the game API.
---
--- @param name string
---
local unregisterEvent = function(name)
  events[name] = nil -- clear the listener manager for the event.

  if not startsWith(name, 'ADDON_LOADED') then
    frame:UnregisterEvent(name)
  end
end

---
--- The core event handler invokes events, registers and removes listeners,
--- and manages event-related logic.
---
--- @type events.handler
---
local handler = {
  --
  -- Triggers a registered event, invoking all its associated listeners
  -- and potentially unregistering the event if no listeners remain.
  --
  invokeEvent = function(event, arguments)
    if events[event] ~= nil then
      events[event]:invokeListeners(arguments)

      if #events[event].listeners == 0 then
        unregisterEvent(event)
      end
    end
  end,

  --
  -- Registers a listener for a specified event, creating the event if necessary, and
  -- optionally associating the listener with a context for identification purposes.
  --
  registerListener = function(event, listener, context)
    if events[event] == nil then
      registerEvent(event)
    end

    -- Formats the listener identifier to include the context identifier when both are provided.
    if type(context) == 'table' and context.identifier and listener.identifier then
      listener.identifier = string.format('%s:%s', context.identifier, listener.identifier)
    end

    events[event]:registerListener(listener)
  end,

  --
  -- Removes a listener from a specified event, optionally using context
  -- for identification, and unregisters the event if no listeners remain.
  --
  removeListener = function(event, identifier, context)
    if events[event] == nil then
      throw('Listener removal failed. No listeners registered for event "%s"', event)
    end

    if type(context) == 'table' and context.identifier then
      identifier = string.format('%s:%s', context.identifier, identifier)
    end

    events[event]:removeListener(identifier)

    if #events[event].listeners == 0 then
      unregisterEvent(event)
    end
  end
}

-- #region << exports >>
framework.export('events/handler', handler)
-- #endregion
