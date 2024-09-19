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

    -- ?

    for i = 1, #self.listeners do
      -- ?

      ((executeAsync and tasks.executeTaskAsync) or tasks.executeTask)(
        self.listeners[i].callback, arguments or {}
      )

      -- ?

      if self.listeners[i].persistent == false then
        table.remove(self.listeners, i)
        i = i - 1 -- ?
      end
    end
  end,

  -- ?

  registerListener = function(self, listener)
    --
    -- ?

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

    -- ?

    table.insert(self.listeners, listener)
  end,

  -- ?

  removeListener = function(self, identifier)
    --
    -- ?

    if type(identifier) ~= 'string' then
      exception.type('identifier', 'string', type(identifier))
    end

    -- ?

    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- ?
      end
    end

    exception.generic('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,
}

---
--- ?
---
--- @param object? table    "..."
--- @return listenerManager "..."
---
_G.createListenerManager = function(object)
  return inheritFromParent(integrateTable(object or {}, { listeners = {} }), listenerManager)
end
