---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

--[[~ Component: Listenable ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/25

  This component manages registration, removal, and invocation of listeners.

  Features:

  - Register and remove listeners for specific events.
  - Invoke listeners synchronously or asynchronously.
  - Handle persistent and non-persistent listeners.

]]

---@type listenable
local listenable = {
  registerListener = function(self, listener)
    xtype.validate {
      { 'listener:table', listener },
      { 'listener.callback:function', listener.callback },
      { 'listener.identifier:string', listener.identifier },
      { 'listener.persistent:boolean?', listener.persistent },
    }

    table.insert(self.listeners, listener)
  end,

  removeListener = function(self, identifier)
    xtype.validate {
      { 'identifier:string', identifier },
    }

    for index, listener in ipairs(self.listeners) do
      if listener.identifier == identifier then
        table.remove(self.listeners, index)
        return -- exit.
      end
    end

    throw('Failed to remove listener "%s" (unknown identifier).', identifier)
  end,

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

        local callback = (options.async and api.executeCallbackAsync) or api.executeCallback
        callback(listener.identifier, listener.callback, arguments or {})

        if listener.persistent == false then
          table.remove(self.listeners, currentIndex)
        else
          currentIndex = currentIndex + 1
        end
      end
    end
  end,
}

---@type listenableConstructor
local constructor = function()
  return inheritParent({ listeners = {} }, listenable)
end

repository.expose('listenable', constructor)
