--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework      = ...

local exception             = _G.exception
local type                  = _G.type

local createList            = framework.import('collection/list') --[[@as ListConstructor]]
local executeCallback       = framework.import('module/callbacks') --[[@as CallbackHandler]]
local mergeTables           = framework.import('table/merge') --[[@as TableMerger]]

--
-- Manages a collection of event listeners, providing methods for registration,
-- retrieval, removal, and invocation of listeners.
--

--- @type ListenerManager
local manager               =
{
  --
  -- Registers an event listener, validating its structure and adding it to the list
  --

  registerListener = function(self, listener)
    --~ We validate the listener object's structure and types to ensure
    --~ it adheres to the expected format and avoid runtime errors.

    if type(listener) ~= 'table' then
      exception('Invalid listener argument. Expected a table representing a listener object.')
    end

    if listener.identifier and type(listener.identifier) ~= 'string' then
      exception('Invalid listener identifier. Expected a string or nil.')
    end

    if type(listener.callback) ~= 'function' then
      exception('Invalid listener callback. Expected a function.')
    end

    if listener.recurring ~= nil then
      if type(listener.recurring) ~= 'boolean' then
        exception('Invalid listener `recurring` flag. Expected a boolean or nil.')
      end
    end

    --~ Add the validated listener to the list.

    self.listeners:insert(listener)
  end,

  --
  -- Retrieves a listener by its unique identifier, which is useful
  -- for managing or manipulating specific listeners.
  --

  retrieveListener = function(self, identifier)
    if type(identifier) ~= 'string' then
      exception('Invalid listener identifier. Expected a string.')
    end

    for index, listener in ipairs(self.listeners.values) do
      --- @cast listener Listener

      if listener.identifier == identifier then return listener end
    end
  end,

  --
  -- Removes a listener using its unique identifier. This allows for
  -- dynamic management of event subscriptions.
  --

  removeListener = function(self, identifier)
    if type(identifier) ~= 'string' then
      exception('Invalid listener identifier. Expected a string.')
    end

    for index, listener in ipairs(self.listeners.values) do
      --- @cast listener Listener

      if listener.identifier == identifier then
        self.listeners:removeElementAt(index)

        break -- cancel the loop.
      end
    end
  end,

  --
  -- Invokes all registered listeners, passing the arguments to their respective
  -- callbacks, while also supporting both synchronous and asynchronous execution.
  --
  -- Non-recurring listeners are removed after invocation.
  --

  invokeListeners = function(self, arguments, async)
    local oneTimeListeners = createList()

    for index, listener in ipairs(self.listeners.values) do
      --- @cast listener Listener

      executeCallback(
        listener.callback, { arguments = arguments, async = async }
      )

      if listener.recurring == false then
        oneTimeListeners:insert(index)
      end
    end

    local listenerCount = oneTimeListeners:size()

    if listenerCount > 0 then
      for i = listenerCount, 1, -1 do
        self.listeners:removeElementAt(i)
      end
    end
  end
}

--
-- This factory function creates new listener manager instances,
-- each with its own list of listeners.
--

--- @type ListenerManagerConstructor
local createListenerManager = function()
  return mergeTables({ listeners = createList() }, manager)
end

--
-- Exports the factory function, allowing other modules to create 
-- and manage their own sets of event listeners.
--
framework.export('shared/listeners', createListenerManager)
