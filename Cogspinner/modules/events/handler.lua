--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, framework = ...

-- #region << imports >>
--- @type Frame
local frame = framework.import('core/frame')
--- @type listenerManager.constructor
local createListenerManager = framework.import('shared/listeners')
-- #endregion

---
--- ?
---
--- @type table<string, events.listenerManager>
---
local events = {}

---
--- ?
---
--- @param name string
---
local registerEvent = function(name)
  if not startsWith(name, 'ADDON_LOADED') then frame:RegisterEvent(name) end
  events[name] = createListenerManager() --[[@as events.listenerManager]]
end

---
--- ?
---
--- @param name string
---
local unregisterEvent = function(name)
  if not startsWith(name, 'ADDON_LOADED') then frame:UnregisterEvent(name) end
  events[name] = nil -- clears the listener manager for the event.
end

---
--- ?
---
--- @type events.handler
---
local handler = {
  --
  -- ?
  --
  invokeEvent = function(event, arguments)
    if events[event] ~= nil then
      events[event]:invokeListeners(arguments)

      -- ?
      if #events[event].listeners == 0 then unregisterEvent(event) end
    end
  end,

  --
  -- ?
  --
  registerListener = function(event, listener, context)
    if events[event] == nil then registerEvent(event) end

    -- ?
    if type(context) == 'table' and context.identifier and listener.identifier then
      listener.identifier = string.format('%s:%s', context.identifier, listener.identifier)
    end

    events[event]:registerListener(listener)
  end,

  --
  -- ?
  --
  removeListener = function(event, identifier, context)
    if events[event] == nil then
      throw('Listener removal failed. No listeners registered for event "%s"', event)
    end

    if type(context) == 'table' and context.identifier then
      identifier = string.format('%s:%s', context.identifier, identifier)
    end

    events[event]:removeListener(identifier)

    -- ?
    if #events[event].listeners == 0 then unregisterEvent(event) end
  end
}

-- #region << exports >>
framework.export('events/handler', handler)
-- #endregion
