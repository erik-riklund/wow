--[[~ Module: Error Handler ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/14

]]

---
--- Throws a formatted exception with the provided message and optional arguments.
---
---@param message string
---@param ... string | number
backbone.throwException = function(message, ...)
  error((... and string.format(message, ...)) or message, 3)
end
