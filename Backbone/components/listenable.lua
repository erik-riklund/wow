--[[~ Component: Listenable ~
  
  Author(s): Erik Riklund (Gopher)
  Updated: 2024/10/21
]]

---@type Listenable
---@diagnostic disable-next-line: missing-fields
local listenable = {}

---
--- ?
---
listenable.registerListener = function(self, listener)
  self.listeners[#self.listeners + 1] = listener --
end

---
--- ?
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
--- ?
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
--- ?
---
---@return Listenable
---
backbone.components.createListenable = function()
  return backbone.utilities.inheritParent({ listeners = {} }, listenable)
end
