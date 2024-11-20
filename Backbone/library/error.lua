--[[~ ? (utility) ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param message string
---@param ... string|number
---
Error = function(message, ...)
  error(... and string.format(message, ...) or message, 3)
end
