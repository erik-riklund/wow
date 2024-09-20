---@type string, context
local addon, context = ...
local tasks = context:use 'tasks' --[[@as taskHandler]]

--[[

  Project: Stem (framework)
  Module: Listener Manager
  Version: 1.0.0

  Description:
  This module manages the registration, invocation, and removal of event listeners.
  It supports asynchronous execution of listeners and ensures listener persistence
  based on user configuration.

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Dependencies:

  - tasks (taskHandler for async execution)
  - exception (for error handling)

  Notes:

  - The `listeners` are stored as a table. Each listener is expected to have the following fields:
    - `callback`   (function): The function to be invoked.
    - `identifier` (optional, string): A unique identifier for the listener.
    - `persistent` (optional, boolean): If `false`, the listener is removed after execution.
  
  Usage:

  -- Create a new listener manager
  local manager = createListenerManager()

  -- Register a listener
  manager:registerListener({
    callback = function(args) print('Hello world') end,
    identifier = 'hello_listener',
    persistent = true
  })

  -- Invoke listeners with arguments, optionally executing asynchronously
  manager:invokeListeners({ message = 'Hello' }, false)

  -- Remove a listener by identifier
  manager:removeListener('hello_listener')

]]

---
--- Manages the lifecycle of listeners, including registration, invocation,
--- and removal of event listeners.
---
--- @type listenerManager
---
local listenerManager = {
  --
  -- Invokes all registered listeners, passing the provided arguments to their
  -- respective callback functions. Supports both synchronous and asynchronous execution.

  invokeListeners = function(self, arguments, executeAsync)
    --
    -- Validate the input arguments to avoid unexpected behavior.

    if arguments ~= nil and type(arguments) ~= 'table' then
      exception.type('arguments', 'table', type(arguments))
    end

    if executeAsync ~= nil and type(executeAsync) ~= 'boolean' then
      exception.type('executeAsync', 'boolean', type(executeAsync))
    end

    -- Execute each listener's callback, either synchronously or asynchronously.

    for i = 1, #self.listeners do
      --

      ((executeAsync and tasks.executeTaskAsync) or tasks.executeTask)(
        self.listeners[i].callback,
        arguments or {}
      )

      -- If the listener is not persistent, it is removed after execution.

      if self.listeners[i].persistent == false then
        table.remove(self.listeners, i)
        i = i - 1 -- adjusts the index to ensure correct iteration after removal.
      end
    end
  end,

  -- Registers a new listener with a callback function, optional identifier,
  -- and persistence flag. Ensures that all fields are of the correct types.

  registerListener = function(self, listener)
    --
    -- Validate the listener structure and its fields.

    if type(listener) ~= 'table' then
      exception.type('listener', 'table', type(listener))
    end

    if type(listener.callback) ~= 'function' then
      exception.type('listener.callback', 'function', type(listener.callback))
    end

    if listener.identifier ~= nil and type(listener.identifier) ~= 'string' then
      exception.type('listener.identifier', 'string', type(listener.identifier))
    end

    if listener.persistent ~= nil and type(listener.persistent) ~= 'boolean' then
      exception.type('listener.persistent', 'boolean', type(listener.persistent))
    end

    -- Insert the validated listener into the list of listeners.

    table.insert(self.listeners, listener)
  end,

  -- Removes a listener by its identifier. Throws an error if no listener with
  -- the given identifier is found.

  removeListener = function(self, identifier)
    --
    -- Validate that the identifier is a string.

    if type(identifier) ~= 'string' then
      exception.type('identifier', 'string', type(identifier))
    end

    -- Search for the listener by identifier and remove it if found.

    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- exits after the listener is removed.
      end
    end

    -- Throws an error if the listener with the given identifier was not found.

    exception.generic('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,
}

---
--- Creates a new listener manager, optionally integrating it with an existing object.
--- The manager allows for the registration, invocation, and removal of listeners.
---
--- @param object? table    "Optionally, an existing object to integrate with."
--- @return listenerManager "Returns the created listener manager."
---
_G.createListenerManager = function(object)
  return inheritFromParent(integrateTable(object or {}, { listeners = {} }), listenerManager)
end
