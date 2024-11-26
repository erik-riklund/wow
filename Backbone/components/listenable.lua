
--[[~ Updated: 2024/11/20 | Author(s): Gopher ]]

---@class Listenable
---Provides functionality for managing and notifying listeners.
local listenable = {}

---@protected
---@type Vector
listenable.listeners = nil

---Returns the current number of registered listeners.
listenable.getListenerCount = function (self)
  return self.listeners:getSize ()
end

---Registers a new listener to receive notifications.
---@param listener Listener
listenable.registerListener = function (self, listener)
  self.listeners:insertElement (listener)
end

---Removes a listener identified by a unique identifier.
---@param identifier string
listenable.removeListener = function (self, identifier)
  for index, listener in self.listeners:getIterator () do
    ---@cast listener Listener
    if listener.identifier == identifier then
      self.listeners:removeElement (index)

      return -- halt execution once the listener is removed.
    end
  end
end

---Invokes all registered listeners with the provided arguments.
---Non-persistent listeners are removed after execution.
---@param arguments? Vector
---@param async? boolean
listenable.invokeListeners = function (self, arguments, async)
  local nonpersistent_listeners = new 'Vector'
  local execute = (async == false and backbone.executeTask) or backbone.executeTaskAsync

  self.listeners:forEach(
    function (index, listener)
      ---@cast listener Listener
      
      execute { callback = listener.callback, identifier = listener.identifier, arguments = arguments }
      if listener.persistent == false then nonpersistent_listeners:insertElement (index) end
    end
  )

  for i = nonpersistent_listeners:getSize(), 1, -1 do
    self.listeners:removeElement (nonpersistent_listeners:getElement (i))
  end
end

---Prototype object for creating new `Listenable` instances.
local prototype = { __index = listenable }

---Creates a new Listenable instance.
Listenable = function ()
  return setmetatable ({ listeners = new 'Vector' }, prototype)
end
