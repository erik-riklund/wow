--[[~ Listenable (component) ~
  Updated: 2024/11/19 | Author(s): Erik Riklund (Gopher)
]]

---
---@class Listenable
---
local listenable = {}

---
--- ?
---
---@protected
---@type Vector
---
listenable.listeners = nil

---
--- ?
---
---@param listener Listener
---
listenable.registerListener = function(self, listener)
  print 'listenable.registerListener not implemented' --
end

---
--- ?
---
---@param identifier string
---
listenable.removeListener = function(self, identifier)
  print 'listenable.removeListener not implemented' --
end

---
--- ?
---
---@param arguments? Vector
---
listenable.invokeListeners = function(self, arguments)
  local nonpersistent_listeners = new 'Vector'
  self.listeners:forEach(function(index, element)
    -- ?
  end)

  print 'listenable.invokeListeners: not implemented.' --
end

---
--- ?
---
local prototype = { __index = listenable }

---
--- ?
---
Listenable = function()
  return setmetatable({ listeners = new 'Vector' }, prototype) --
end
