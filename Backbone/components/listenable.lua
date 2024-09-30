---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

--[[~ Component: Listenable ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  Provides a mechanism for registering, removing, and invoking listeners,
  which can respond to specific events or actions.

  Features:

  - Supports registering and removing listeners.
  - Invokes registered listeners with optional arguments.
  - Handles both persistent and non-persistent listeners.

]]

---@type listenable
local listenable = {
  -- Registers a listener with the component, validating its structure and ensuring
  -- it contains the required fields such as a callback and identifier.

  registerListener = function(self, listener)
    xtype.validate {
      { 'listener:table', listener },
      { 'listener.callback:function', listener.callback },
      { 'listener.identifier:string', listener.identifier },
      { 'listener.persistent:boolean?', listener.persistent },
    }

    table.insert(self.listeners, listener)
  end,

  -- Removes a listener from the component by its identifier. If the identifier
  -- is unknown, an error is thrown.

  removeListener = function(self, identifier)
    xtype.validate {
      { 'identifier:string', identifier },
    }

    -- Iterates through the list of listeners to find and remove the one that
    -- matches the given identifier.

    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- Successfully removed the listener.
      end
    end

    throw('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,

  -- Invokes all registered listeners, passing the provided arguments and handling
  -- options for synchronous or asynchronous execution. Non-persistent listeners
  -- are removed after being invoked.

  invokeListeners = function(self, arguments, options)
    options = options or {}

    xtype.validate {
      { 'arguments:array?', arguments },
      { 'options:table?', options },
      { 'options.async:boolean?', options.async },
    }

    local listenerCount = #self.listeners

    -- If listeners are present, iterates through them to invoke their callbacks,
    -- removing non-persistent listeners after invocation.

    if listenerCount > 0 then
      local currentIndex = 1

      for i = 1, listenerCount do
        local listener = self.listeners[currentIndex]

        -- Chooses the appropriate method for invoking the callback (synchronous
        -- or asynchronous) and executes it.

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

-- Constructs and returns a new instance of the Listenable component with an
-- empty list of listeners.

---@type listenableConstructor
local constructor = function() return inheritParent({ listeners = {} }, listenable) end

-- Exposes the Listenable component through the repository, making it available
-- for use by other components or modules.

repository.expose('listenable', constructor)
