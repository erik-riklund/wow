--[[~ Updated: 2024/12/06 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

---@class Listenable
---
local listenable = {}
local prototype = { __index = listenable }

---@protected
---@type Vector
---
listenable.listeners = nil

---Returns the total number of registered listeners.
---
listenable.getListenerCount = function (self)
  return self.listeners:getSize()
end

---@param listener Listener
---Registers a new listener.
listenable.registerListener = function (self, listener)
  self.listeners:insertElement (listener)
end

---@param id string
---Removes a listener by its identifier.
---
listenable.removeListener = function (self, id)
  for index, listener in self.listeners:getIterator() do
    ---@cast listener Listener
    if listener.id == id then
      self.listeners:removeElement (index)

      return -- halt execution once the listener is removed.
    end
  end
end

---@param arguments? Vector
---@param executeAsync? boolean
---Invokes all registered listeners, passing the provided arguments to their callback functions.
---* Non-persistent listeners are automatically removed after execution.
---
listenable.invokeListeners = function (self, arguments, executeAsync)
  local nonpersistentListeners = new 'Vector'
  local execute = (executeAsync == false and backbone.executeTask)
                    or backbone.executeBackgroundTask

  self.listeners:forEach(
    function (index, listener)
      ---@cast listener Listener
      
      execute {
        callback = listener.callback,
        identifier = listener.id,
        arguments = arguments
      }
      
      if listener.persistent == false then
        nonpersistentListeners:insertElement (index)
      end
    end
  )

  for i = nonpersistentListeners:getSize(), 1, -1 do
    self.listeners:removeElement (nonpersistentListeners:getElement (i))
  end
end

---Creates a new `Listenable` instance.
---
Listenable = function ()
  return setmetatable ({ listeners = new 'Vector' }, prototype)
end
