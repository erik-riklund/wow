--[[~ Listenable ~
  Updated: 2024/10/22 | Author(s): Erik Riklund (Gopher)
]]

---
--- Represents an object that manages a list of listeners,
--- allowing them to be invoked, registered, or removed.
---
---@class Listenable
---
local listenable = {}

---
--- A list of registered listeners.
---
---@protected
---@type Listener[]
---
listenable.listeners = {}

---
--- ?
---
listenable.getListenerCount = function(self) return #self.listeners end

---
--- Registers a new listener by adding it to the list of listeners.
---
---@param listener Listener
---
listenable.registerListener = function(self, listener)
  self.listeners[#self.listeners + 1] = listener
end

---
--- Removes the listener with the specified identifier from the list.
---
---@param identifier string
---
listenable.removeListener = function(self, identifier)
  for index, listener in ipairs(self.listeners) do
    if listener.identifier == identifier then
      table.remove(self.listeners, index)
      return -- exit after removing the listener.
    end
  end
end

---
--- Invokes all registered listeners, with options to pass arguments and to choose
--- between synchronous or asynchronous execution.
---
---@param options Listenable.invokeListeners.options
---
listenable.invokeListeners = function(self, options)
  local method = backbone.executeCallbackAsync
  if options and options.executeSync == true then
    method = backbone.executeCallback --
  end

  local currentIndex = 1
  for i = 1, #self.listeners do
    local listener = self.listeners[currentIndex]

    method {
      identifier = listener.identifier,
      callback = listener.callback,
      arguments = (options and options.arguments) or nil,
    }

    if listener.persistent == false then
      table.remove(self.listeners, currentIndex)
    else
      currentIndex = currentIndex + 1
    end
  end
end

---
--- Creates and returns a new `Listenable` component, with an empty list of listeners.
---
---@return Listenable
---
backbone.components.createListenable = function()
  return backbone.utilities.inheritParent({ listeners = {} }, listenable)
end
