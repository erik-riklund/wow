--[[~ Component: Listenable ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/07

  Provides a component for managing event listeners, supporting registration, 
  invocation, and removal of listeners with both persistent and non-persistent 
  behavior. Listeners can be executed either synchronously or asynchronously.

]]

---@type Listenable
local listenable = {
  --
  -- Executes the registered listeners with the given arguments,
  -- using asynchronous execution by default.

  -- Non-persistent listeners are removed after invocation.

  invokeListeners = function(self, arguments, async)
    local listenerCount = #self.listeners
    local invocationMethod = backbone.executeCallbackAsync

    if type(arguments) ~= 'table' then arguments = {} end
    if async == false then invocationMethod = backbone.executeCallback end

    if listenerCount > 0 then
      local currentIndex = 1

      for n = 1, listenerCount do
        local listener = self.listeners[currentIndex]
        invocationMethod(listener.identifier, listener.callback, arguments)

        if listener.persistent == false then
          table.remove(self.listeners, currentIndex)
        else
          currentIndex = currentIndex + 1
        end
      end
    end
  end,

  -- Registers a new listener. In development mode, the uniqueness of the
  -- identifier is enforced, throwing an error to prevent naming conflicts.

  registerListener = function(self, identifier, callback, persistent)
    if backbone.getEnvironment() == 'development' then
      for _, listener in ipairs(self.listeners) do
        if listener.identifier == identifier then
          backbone.throwError(
            'Failed to register listener "%s" (non-unique identifier).',
            identifier
          )
        end
      end
    end

    table.insert(self.listeners, {
      identifier = identifier,
      callback = callback,
      persistent = (type(persistent) == 'boolean' and persistent) or false,
    })
  end,

  -- Removes the listener with the specified identifier. In development mode,
  -- an error is thrown if the listener does not exist to prevent logical errors.

  removeListener = function(self, identifier)
    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- exit the process after removing the listener.
      end
    end

    if backbone.getEnvironment() == 'development' then
      backbone.throwError('Listener removal failed, unknown listener "%s".', identifier)
    end
  end,
}

---
--- Creates a new instance of the `Listenable` component.
---
---@return Listenable
---
backbone.createListenableComponent = function()
  return utilities.inheritParent({ listeners = {} }, listenable)
end
