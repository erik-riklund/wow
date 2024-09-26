---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

--[[~ Component: Listenable ~

  Version: 1.0.0 | Updated: 2024/09/25

  The Listenable component manages event listeners, allowing registration, removal, 
  and invocation of listeners. This component is useful for plugins or systems 
  that need to react to specific events.

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
        return
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

    for i = 1, #self.listeners do
      local listener = self.listeners[i];

      ((options.async and api.executeCallbackAsync) or api.executeCallback)(
        listener.identifier,
        listener.callback,
        arguments or {}
      )

      if listener.persistent == false then
        table.remove(self.listeners, i)
        i = i - 1 -- Adjust the index to account for the removed listener.
      end
    end
  end,
}

---@type listenableConstructor
local constructor = function()
  return inheritParent({ listeners = {} }, listenable)
end

repository.expose('listenable', constructor)
