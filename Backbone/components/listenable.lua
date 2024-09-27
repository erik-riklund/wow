---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

--[[~ Component: Listenable ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This component manages registration, removal, and invocation of listeners.

  Features:

  - Register and remove listeners for specific events.
  - Invoke listeners synchronously or asynchronously.
  - Handle persistent and non-persistent listeners.

]]

---@type listenable
local listenable = {
  --
  -- registerListener()
  --
  -- This function registers a new listener to the listenable component. It validates that the 
  -- listener object contains a valid `callback` function, `identifier`, and optionally, a 
  -- `persistent` flag. The listener is then added to the list of listeners.
  --

  registerListener = function(self, listener)
    xtype.validate {
      { 'listener:table', listener },
      { 'listener.callback:function', listener.callback },
      { 'listener.identifier:string', listener.identifier },
      { 'listener.persistent:boolean?', listener.persistent },
    }

    table.insert(self.listeners, listener)
  end,

  --
  -- removeListener()
  --
  -- This function removes a listener from the list based on its `identifier`. If the identifier 
  -- matches a registered listener, the listener is removed. If no match is found, an error is 
  -- thrown. This ensures that only known listeners can be removed.
  --

  removeListener = function(self, identifier)
    xtype.validate {
      { 'identifier:string', identifier },
    }

    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- Successfully removed the listener.
      end
    end

    throw('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,

  --
  -- invokeListeners()
  --
  -- This function invokes all registered listeners. It accepts an optional array of arguments 
  -- and an options table to control whether the listeners should be invoked asynchronously. 
  -- If the listener is not persistent, it is removed after invocation.
  --

  invokeListeners = function(self, arguments, options)
    options = options or {}

    xtype.validate {
      { 'arguments:array?', arguments },
      { 'options:table?', options },
      { 'options.async:boolean?', options.async },
    }

    local listenerCount = #self.listeners

    if listenerCount > 0 then
      local currentIndex = 1

      for i = 1, listenerCount do
        local listener = self.listeners[currentIndex]

        -- Determine whether to invoke the listener synchronously or asynchronously. The appropriate 
        -- callback function (`api.executeCallback` or `api.executeCallbackAsync`) is selected based 
        -- on the `async` flag in the options.
        
        local callback = (options.async and api.executeCallbackAsync) or api.executeCallback
        callback(listener.identifier, listener.callback, arguments or {})

        if listener.persistent == false then
          table.remove(self.listeners, currentIndex) -- Remove non-persistent listeners after invocation.
        else
          currentIndex = currentIndex + 1 -- Increment the index for persistent listeners.
        end
      end
    end
  end,
}

--
-- constructor()
--
-- This function constructs a new listenable object by inheriting the `listenable`
-- component's methods and initializing an empty list of listeners. The resulting
-- object can then register, remove, and invoke listeners.
--

---@type listenableConstructor
local constructor = function()
  return inheritParent({ listeners = {} }, listenable)
end

--
-- Expose the `listenable` constructor through the repository, allowing other components or  
-- plugins to create new instances of the listenable component for managing event listeners.
--

repository.expose('listenable', constructor)
