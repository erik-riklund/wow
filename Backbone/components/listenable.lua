---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

--[[~ Component: Listenable ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  This component provides a mechanism for registering, invoking, and removing listeners.
  Listeners are functions that respond to specific events or actions within the framework.
  Each listener is uniquely identified by an identifier and can be marked as persistent, 
  meaning it will remain active until explicitly removed.

  Developer's notes:
  
  - Listeners are registered with unique identifiers to ensure they are managed 
    appropriately within the system.
  
  - The component supports both synchronous and asynchronous execution of listeners,
    giving developers flexibility in how they handle events.
  
  - Persistent listeners remain active until explicitly removed, while non-persistent 
    listeners are removed after they are invoked.

  Dependencies: xtype (for type validation)

]]

---
--- The `listenable` table acts as a prototype for all objects that need to manage 
--- listeners. It provides methods for registering, invoking, and removing listeners.
---
---@type listenable
---
local listenable = {
  ---
  --- Registers a listener to be invoked when an event occurs. The listener must 
  --- include a callback function, an identifier, and an optional persistence flag.
  --- This allows the framework to manage event-driven behaviors efficiently.
  ---
  registerListener = function(self, listener)
    xtype.validate {
      { 'listener:table', listener },
      { 'listener.callback:function', listener.callback },
      { 'listener.identifier:string', listener.identifier },
      { 'listener.persistent:boolean?', listener.persistent },
    }

    -- Add the listener to the internal listeners table for future invocation.
    -- This table tracks all registered listeners, allowing them to be called 
    -- when specific events occur.

    table.insert(self.listeners, listener)
  end,

  ---
  --- Removes a listener from the list based on its unique identifier. If the 
  --- listener is found, it is removed, ensuring it will no longer be invoked.
  --- This allows for precise control over active listeners.
  ---
  removeListener = function(self, identifier)
    xtype.validate {
      { 'identifier:string', identifier },
    }

    -- Search for the listener in the internal listeners table. If a matching 
    -- identifier is found, the listener is removed. This prevents the listener 
    -- from being triggered in future event invocations.

    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return
      end
    end

    throw('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,

  ---
  --- Invokes all registered listeners, passing any provided arguments. This method 
  --- also handles asynchronous invocation if specified. Non-persistent listeners 
  --- are removed after they are invoked, while persistent ones remain active.
  ---
  invokeListeners = function(self, arguments, options)
    options = options or {}

    xtype.validate {
      { 'arguments:array?', arguments },
      { 'options:table?', options },
      { 'options.async:boolean?', options.async },
    }

    -- Iterate through the registered listeners and invoke each one. If the listener 
    -- is marked as non-persistent, it is removed after being invoked to prevent 
    -- future invocations. This ensures only relevant listeners remain active.

    for i = 1, #self.listeners do
      local listener = self.listeners[i];

      ((options.async and api.executeCallbackAsync) or api.executeCallback)(
        listener.identifier,
        listener.callback,
        arguments or {}
      )

      if listener.persistent == false then
        table.remove(self.listeners, i)
        i = i - 1 -- Adjust the index to prevent skipping listeners after removal.
      end
    end
  end,
}

---
--- Exposes the `listenable` component, allowing other parts of the framework 
--- to create objects that inherit the functionality for managing listeners.
---
repository.expose('listenable', function()
  return inheritParent({ listeners = {} }, listenable)
end)
