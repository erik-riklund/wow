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
--- @type dispatch.executeCallback
local executeCallback = framework.import('dispatch/execute')
-- #endregion

--
-- An object prototype providing methods for managing listeners (callbacks)
-- associated with specific events or triggers.
--

--- @type listenerManager
local listenerManager = {
  --
  -- Registers a new listener with a callback function. An optional identifier
  -- can be provided, which is necessary for future removal of the listener.
  --
  registerListener = function(self, listener) table.insert(self.listeners, listener) end,

  --
  -- Removes a listener from the list, identifying it by its unique identifier.
  --
  removeListener = function(self, identifier)
    for index, listener in ipairs(self.listeners) do
      if listener.identifier and listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- task is completed, stop execution.
      end
    end

    throw('Listener removal failed, unknown listener "%s"', identifier)
  end,

  --
  -- Invokes all registered listeners, passing the provided arguments to each,
  -- where the `executeAsync` flag determines whether callbacks are executed
  -- asynchronously or not.
  --
  invokeListeners = function(self, arguments, executeAsync)
    for index, listener in ipairs(self.listeners) do
      executeCallback(listener.callback, arguments, { async = executeAsync })
    end

    self:removeNonrecurringListeners()
  end,

  --
  -- Removes non-recurring listeners after invocation.
  --
  removeNonrecurringListeners = function(self)
    for index = #self.listeners, 1, -1 do
      if self.listeners[index].recurring == false then table.remove(self.listeners, index) end
    end
  end
}

--
-- Creates new `listenerManager` instances, providing a way to encapsulate
-- and manage listeners in different parts of the framework.
--
--- @type listenerManager.constructor
--
local createListenerManager = function()
  return {
    -- An empty table to store listeners for this specific instance.

    listeners = {},

    -- Methods inherited from the `listenerManager` prototype, providing the core
    -- functionality for registering, removing, and invoking listeners.

    invokeListeners = listenerManager.invokeListeners,
    registerListener = listenerManager.registerListener,
    removeListener = listenerManager.removeListener,
    removeNonrecurringListeners = listenerManager.removeNonrecurringListeners
  }
end

-- #region << exports >>
framework.export('shared/listeners', createListenerManager)
-- #endregion
